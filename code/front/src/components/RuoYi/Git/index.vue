<template>
  <div>
    <svg-icon icon-class="github" @click="goto" />
  </div>
</template>

<script>
export default {
  name: 'RuoYiGit',
  data() {
    return {
      url: 'http://192.168.9.29:20003/'
    }
  },
  methods: {
    goto() {
      window.open(this.url)
    }
  }
}
</script>