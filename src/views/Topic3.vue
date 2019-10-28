<template>
  <div>
    <b-container fluid>
      <QuestionBox
        v-if="questions.length"
        :currentQuestion="questions[index]"
        :next="next"
        :previous="previous"
        :increment="increment"
      />
    </b-container>
  </div>
</template>

<script>
import questions from '@/data/topic3'
import QuestionBox from '@/components/QuestionBox.vue'

export default {
  components: {
    QuestionBox
  },

  data () {
    return {
      questions,
      index: 0,
      numCorrect: 0,
      numTotal: 0
    }
  },
  methods: {
    next: function () {
      this.index++
    },
    previous: function () {
      this.index--
    },
    increment (isCorrect) {
      if (isCorrect) {
        this.numCorrect++
      }
      this.numTotal++
    }
  }
  // mounted: function () {
  //   // fetch('https://opentdb.com/api.php?amount=10', {
  //   //   method: 'get'
  //   // })
  //   fetch('/test.json')
  //     .then(response => {
  //       return response.json()
  //     })
  //     .then(jsonData => {
  //       this.questions = jsonData.results
  //     })
  // }
}
</script>
