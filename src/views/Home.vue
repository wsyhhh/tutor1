<template>
  <div class="home">
    <h1> tutoR  I'm testing by team Oof</h1>
    <b-table striped hover :items="videos">
      <template v-slot:cell(link)="data">
        <!--a :href="`#${data.value.replace(/[^a-z]+/i,'-').toLowerCase()}`">{{ data.value }}</a-->
        <!--a :href="`${data.value}`">{{ data.value }}</a-->
      </template>
    </b-table>
  </div>
</template>

<script>
import videos from '@/data/videos'

export default {
  name: 'home',
  data () {
    return {
      videos
    }
  }
}
</script>
