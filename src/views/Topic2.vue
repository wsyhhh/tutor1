<template>
  <div>
      <div class="mx-auto bg-info" style="width: 600px" >
        <b-embed
            type="iframe"
            aspect="16by9"
            src="https://www.youtube.com/embed/1jUeGxyiSZk"
            allowfullscreen
        ></b-embed>
        </div>
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
import questions from '@/data/topic2'
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
}
</script>
