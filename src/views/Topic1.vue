<template>
  <div>
    <h1>Introduction to R</h1>
    <div class="mx-auto bg-info" style="width: 600px">
      <b-embed
        type="iframe"
        aspect="16by9"
        src="https://www.youtube.com/embed/etp33vqdYNI"
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
      <div class="form-group">
        <label for="exampleInputEmail1">Answer</label>
        <textarea> Test </textarea>
      </div>
      <button type="submit" class="btn btn-primary" v-on:click="submit">Submit</button>
      <div class="result">
        <label for="exampleInputEmail1">Result</label>
        <textarea>  </textarea>
      </div>
  </div>
</template>

<script>
import questions from "@/data/topic1";
import QuestionBox from "@/components/QuestionBox.vue";

export default {
  components: {
    QuestionBox
  },

  data() {
    return {
      questions,
      index: 0,
      numCorrect: 0,
      numTotal: 0,
    };
  },
  methods: {
    next: function() {
      this.index++;
    },
    previous: function() {
      this.index--;
    },
    increment(isCorrect) {
      if (isCorrect) {
        this.numCorrect++;
      }
      this.numTotal++;
    },
    submit: function() {
      const gatewayUrl =
        "https://oo3olpgm5m.execute-api.us-east-1.amazonaws.com/default/tutor_week12";
        console.log("hello world");
      fetch(gatewayUrl, {
        method: "POST",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify(
            {code: 'x <- 6'}
        //     {
        //   shown: { 0: this.uiItem.tabItems.test },
        //   editable: { 0: this.uiItem.tabItems.editable },
        //   hidden: { 0: this.uiItem.hidden }
        // }
        )
      });
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
};
</script>
