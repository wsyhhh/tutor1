<template>
  <div class="question-box-container">
    <b-jumbotron>
      <template v-slot:lead>
        {{currentQuestion.question}}
      </template>

			<hr class="my-4">
			<b-list-group>
				<b-list-group-item
					v-for="(answer, index) in shuffledAnswers"
					:key="index"
					@click.prevent="selectAnswer(index)"
					:class="answerClass(index)"
				>
					{{ answer }}
				</b-list-group-item>
			</b-list-group>

			<b-button @click="previous" variant="success" href="#">
				Previous
			</b-button>
			<b-button
				variant="primary"
				@click="submitAnswer"
				:disabled="selectedIndex === null || answered"
			>
				Submit
			</b-button>
            <b-button id="popover-3" variant="primary">Hint</b-button>
            <b-popover target="popover-3" triggers="hover focus">
                <!--template v-slot:title>Content via Slots</template-->
                {{currentQuestion.hint}}
            </b-popover>
			<b-button @click="next" variant="success" href="#">
				Next
			</b-button>
		</b-jumbotron>
	</div>
</template>

<script>
import _ from 'lodash'
export default {
  props: {
    currentQuestion: Object,
    next: Function,
    previous: Function,
    increment: Function
  },

  data () {
    return {
      selectedIndex: null,
      correctIndex: null,
      shuffledAnswers: [],
      answered: false
    }
  },
  computed: {
    answers () {
      let answers = [...this.currentQuestion.incorrect_answers] // make a copy of incorrect_answers
      answers.push(this.currentQuestion.correct_answer)
      return answers
    }
  },
  watch: { // watch for changes in props
    currentQuestion: {
      immediate: true,
      handler () {
        this.selectedIndex = null
        this.answered = false
        this.shuffleAnswers()
      }
    }
  },
  methods: {
    selectAnswer: function (index) {
      this.selectedIndex = index
    },
    shuffleAnswers () {
      let answers = [...this.currentQuestion.incorrect_answers, this.currentQuestion.correct_answer]
      this.shuffledAnswers = _.shuffle(answers)
      this.correctIndex = this.shuffledAnswers.indexOf(this.currentQuestion.correct_answer)
    },
    submitAnswer () {
      let isCorrect = false

      if (this.selectedIndex === this.correctIndex) {
        isCorrect = true
      }
      this.answered = true
      this.increment(isCorrect)
    },
    answerClass (index) {
      let answerClass = ' '
      if (!this.answered && this.selectedIndex === index) {
        answerClass = 'selected'
      } else if (this.answered && this.correctIndex === index) {
        answerClass = 'correct'
      } else if (this.answered && this.selectedIndex === index && this.correctIndex !== index) {
        answerClass = 'incorrect'
      }
      return answerClass
    }
  }
}
</script>

<style scoped>
.list-group {
	margin-bottom: 15px;
}
.list-group-item:hover {
	background: #EEE;
	cursor: pointer
}
.btn {
	margin: 0 5px;
}
.selected {
	background-color: lightblue;
}
.correct {
	background-color: lightgreen ;
}
.incorrect {
	background-color: red;
}

</style>
