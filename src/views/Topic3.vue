<template>
  <div>
    <h1 style="font-size:60px">Basic testing</h1>
    <div class="mx-auto bg-info" style="width: 600px; margin-bottom: 15px">
    <b-embed
        type="iframe"
        aspect="16by9"
        src="https://www.youtube.com/embed/BVsDt-9Sy_g"
        allowfullscreen
    ></b-embed>
    </div>
    <div>
			<b-button v-b-toggle.collapse-1 variant="primary">Summary</b-button>
			<b-collapse id="collapse-1" class="mt-2">
				<b-card style="text-align:left">
					<p> Summary will be added
					</p>
				</b-card>
			</b-collapse>
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
