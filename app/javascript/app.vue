<template>
  <div id="app">
    <div>
      <input v-model="title" placeholder="title">
      <input v-model="page_count" placeholder="page_count">
      <button @click="addBook">読みたい本を追加する</button>
    </div>
    <ul>
      <li v-for="book in filteredData" :key="book.id" class="book_list">
        {{ book.title }} : {{ book.page_count }}ページ
        <button @click="deleteBook(book.id)">削除</button>
        <button @click="book.reading_now = !book.reading_now">この本を読む</button>
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
      reading_now: ''
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
        page_count: this.page_count
      })
        .then(response => (
          this.setBookList()
        ));
    },
    deleteBook: function (id) {
      axios.delete("/api/books/" + id)
        .then(response => (
          this.setBookList()
        ));
    }
  },
  computed: {
    filteredData() {
      const trueData = this.books.filter(book => book.reading_now === true) // trueのデータを抽出
      const falseData = this.books.filter(book => book.reading_now === false) // falseのデータを抽出
      return trueData.concat(falseData)
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

.book_list {
  padding-left: 20px;
  line-height: 1.6em;
  background: url(../assets/images/read_later_icon.png) left 0px top 7px no-repeat;
  background-size: 15px auto;
}
</style>
