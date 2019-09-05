<template>
  <div class="hello">
    <div>
      <input type="file" accept="image/*" @change="fileUpload">
      <br />
    </div>
    <div v-if="loaded">
      <div>
        <button @click="copy">Copy Original</button>
        <br />
        <img :src="originalContent" />
      </div>
      <dv>
        <button @click="copy">Copy Compressed to 1MB</button>
        <br />
        <img :src="compressedContent" />
      </dv>
    </div>
  </div>
</template>

<script>
import imageCompression from 'browser-image-compression';

export default {
  name: 'HelloWorld',
  data () {
    return {
      originalContent: '',
      compressedContent: '',
      loaded: false
    }
  },
  methods: {
    fileUpload: async function (event) {
      let options = {
        maxSizeMB: 1,
        useWebWorker: true
      };
      this.loaded = false;
      let originalFile = event.target.files[0];
      let compressedFile = await imageCompression(originalFile, options);
      this.originalContent = await imageCompression.getDataUrlFromFile(originalFile);
      this.compressedContent = await imageCompression.getDataUrlFromFile(compressedFile);
      this.loaded = true;
    },
    copy: function () {
      navigator.clipboard.writeText(this.originalContent);
    }
    // getStyle: function (cotnent) {
    //   return `background-image: url("${cotnent}")`
    // }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
