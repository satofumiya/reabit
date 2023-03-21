<template>
  <div id="app">
    <div>
      <input v-model="title" placeholder="title">
      <input v-model="page_count" placeholder="page_count">
      <button @click="addBook">読みたい本を追加する</button>
    </div>
    <ul>
      <li v-for="(book, index) in books" :key="book.id" class="book_list">
        {{ book.title }} : {{ book.page_count }}ページ
        <button @click="deleteBook(book.id)">削除</button>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      books: "books",
      id: '',
      title: '',
      page_count: ''
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
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
