<template>
  <div>
    <h1 style="font-size:60px">Basic statistical functions</h1>
      <div class="mx-auto bg-info" style="width: 600px; margin-bottom: 15px">
        <b-embed
					type="iframe"
					aspect="16by9"
					src="https://www.youtube.com/embed/zBEFAhmi570"
					allowfullscreen
        ></b-embed>
        </div>
    <div>
			<b-button v-b-toggle.collapse-summary variant="primary">Summary</b-button>
			<b-collapse id="collapse-summary" class="mt-2">
				<b-card style="text-align:left">
					<p>
						<b>Mean </b>mean(df$col1)
					</p>
					<p>
						<b>Median </b>median(df$col1)
					</p>
					<p>
						<b>Mode</b><br>
					df.freq = table(df$col1)<br>names(df.freq)[df.freq == max(df.freq)]<br>
					## create a frequency table first and match the highest frequency
					</p>
					<p>
						<b>SD: </b>sd(df$col1)
					</p>
					<p>
						<b>Range: </b>range(df$col1)
					</p>
					<p>
						<b>Interquartile range: </b><br>
						IQR(df$col1)<br> or <br>
						quantile(df$col1, c(0.25,0.75))
					</p>
					<p>
						<b>Skewness: </b>skew(df$col1)
					</p>
					<p>
						<b>Kurtosis: </b>kurtosi(df$col1)<br>##not that value is EXCESS kurtosis. (i.e value has been deducted by 3)
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
