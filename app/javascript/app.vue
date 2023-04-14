<template>
  <div id="app">
    <div>
      <input v-model="title" placeholder="title">
      <button @click="addBook" class="btn btn-outline-primary">読みたい本を追加する</button>
    </div>
    <ul>
      <h1>今読む本</h1>
      <li v-for="book in reading" :key="book.id" class="read_now_book_list">
        {{ book.title }}
        <button @click="deleteBook(book.id)">削除</button>
        <button @click="toggleColumnUpdate(book, 'reading_now')">後で読む</button>
        <button @click="toggleColumnUpdate(book, 'finished')">読み終わりました！</button>
      </li>
    </ul>
    <ul>
      <h1>後で読む本</h1>
      <li v-for="book in read_later" :key="book.id" class="read_later_book_list">
        {{ book.title }}
        <button @click="deleteBook(book.id)">削除</button>
        <button @click="toggleColumnUpdate(book, 'reading_now')">この本を読む</button>
      </li>
    </ul>
    <ul>
      <h1>最近読んだ本</h1>
      <li v-for="book in finished_reading" :key="book.id" class="">
        {{ book.title }} : {{ formatDate(book.reading_at) }}
        <button @click="toggleColumnUpdate(book, 'finished')">読み直す！</button>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      books: [],
      id: '',
      title: '',
      page_count: '',
      reading_now: '',
      finished: '',
      reading_at: ''
    }
  },
  mounted() {
    this.setBookList();
  },
  methods: {
    setBookList: function () {
      axios.get('/api/books')
        .then(response => (
          this.books = response.data
        ))
    },
    addBook: function () {
      axios.post('/api/books', {
        title: this.title,
      })
        .then(response => (
          this.setBookList(),
          this.title = ""
        ));
    },
    deleteBook: function (id) {
      axios.delete("/api/books/" + id)
        .then(response => (
          this.setBookList()
        ));
    },
    bookUpdate: function (book, column) {
      const data = {
        [column]: book[column],
      };
      if (column === 'finished') {
        data['reading_at'] = book.reading_at;
      }
      axios.patch("/api/books/" + book.id, data);
    },
    toggleColumn: function (book, column) {
      book[column] = !book[column]
      if (column == 'finished') {
        if (!book.reading_at) {
          book.reading_at = new Date().toISOString()
        } else {
          book.reading_at = null
        }

      }
    },
    toggleColumnUpdate: function (book, column) {
      this.toggleColumn(book, column)
      this.bookUpdate(book, column)
    },
    formatDate: function (date) {
      if (!date) return "";
      date = new Date(date);
      const year = date.getFullYear();
      const month = ('0' + (date.getMonth() + 1)).slice(-2);
      const day = ('0' + date.getDate()).slice(-2);
      return `${year}/${month}/${day}`;
    }
  },
  computed: {
    reading() {
      const readingData = this.books.filter(book => book.reading_now === true && book.finished === false)
      return readingData
    },
    read_later() {
      const read_Later_Data = this.books.filter(book => book.reading_now === false && book.finished === false)
      return read_Later_Data
    },
    finished_reading() {
      const finished_Reading_Data = this.books.filter(book => book.finished === true)
      return finished_Reading_Data
    }
  }
}

</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

ul {
  list-style: none;
}

.read_now_book_list {
  padding-left: 20px;
  line-height: 1.6em;
  background: url(../assets/images/reading_icon.png) left 0px top 7px no-repeat;
  background-size: 15px auto;
}

.read_later_book_list {
  padding-left: 20px;
  line-height: 1.6em;
  background: url(../assets/images/read_later_icon.png) left 0px top 7px no-repeat;
  background-size: 15px auto;
}
</style>
