<template>
  <div id="app">
    <div>
      <input v-model="title" placeholder="title">
      <input v-model="page_count" placeholder="page_count">
      <button @click="addBook">読みたい本を追加する</button>
    </div>
    <ul>
      <li v-for="book in books" :key="book.id">
        {{ book.title }} : {{ book.page_count }}ページ
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
