<template>
  <div>
    <h1 style="font-size:60px">Dataframe Manipulation</h1>
    <div class="mx-auto bg-info" style="width: 600px; margin-bottom: 15px">
      <b-embed
        type="iframe"
        aspect="16by9"
        src="https://www.youtube.com/embed/G_YExroVWF4"
        allowfullscreen
      ></b-embed>
    </div>
		<div>
			<b-button v-b-toggle.collapse-summary variant="primary">Summary</b-button>
			<b-collapse id="collapse-summary" class="mt-2">
				<b-card style="text-align:left">
					<p>
						<b>To set your working directory to allow documents to be imported and exported to a common location</b><br>
						setwd("location to set as directory")<br>## Set working directory<br>
						getwd()<br>## Get current working directory<br>
					</p>
					<p>
						<b>Import excel/csv files from directory</b><br>
						df = read_excel('Credit Risk Data.xlsx', skip = 2)<br> 
						## assigning df the dataframe that is imported<br>
						## “skip = 2” represents skipping the first 2 rows as it is empty<br> 
						## General idea is to get headers as the first row. (done by inspecting the excel file)<br>
					</p>
					<p>
						<b>Export dataframe as csv to directory</b><br>
					write.table(“variable assigned to dataframe”, file = “file name”, sep = “,” , row.names = FALSE)<br>
					write.csv(“variable assigned to dataframe”, file = “file name”, row.names = FALSE)<br>
					# export dataframe as csv to directory<br>
					## ‘ sep = “,” ‘ is to convert file exported to csv format<br>
					## `row.names = TRUE` will result in exported file having a new column of running numbers at the left<br>	
					</p>
					<p>
						<b>To view the dataframe</b><br>
						view(df)
					</p>
					<p>
						<b>To find number of rows / columns in a dataframe</b><br>
						nrow(df)<br>ncol(df)<br>
					</p>
					<p>
						<b>To filter the dataframe</b><br>
						df.filtered = filter(df, some true/false conditions)<br>
						df.filtered = subset(df, some true/false conditions)
						## package(“dplyr”) must be installed and called by executing “library(“dplyr”)
					</p>
					<p>
						<b>To mutate the dataframe</b><br>
						df$name = NA<br>## create new column called (“name”) and assign NA (null values) to them first
					</p>
					<p>
						<b>Retrieve a column vector from dataframe df</b><br>
						df.col = df$”column name”
					</p>
				</b-card>
			</b-collapse>
		</div>
    <b-container fluid>
        <div>
      <QuestionBox
        v-if="questions.length"
        :currentQuestion="questions[index]"
        :next="next"
        :previous="previous"
        :increment="increment"
      /> </div>
		<div>
  		<b-jumbotron header="Interactive Coding" header-level="4" lead="A vector of employee names is given below. Create a dataframe called 'employ.data' from this vector. Create a new column in the dataframe to store the salary of the employees which are 21000, 23400 and 26800 respectively. Find the mean of the salary">
				<div>
				<codemirror class="question" v-model="codeGiven" :options="cmReadOnly">{{codeGiven}}</codemirror>
				</div>
    		<p>Key in your answer in the code editor</p>				
				<div>
					<codemirror class="input" v-model="code" :options="cmOptions"></codemirror>
				</div>
				<div class="result">
					<div>
					<p1>Result</p1>
					</div>
					<textarea v-html="ans"></textarea>
				</div>
					<b-button variant="primary" @click="submitCode">Submit</b-button>
  		</b-jumbotron>
		</div>
		</b-container>
  </div>
</template>

<script>
import questions from "@/data/topic1";
import QuestionBox from "@/components/QuestionBox.vue";
import 'codemirror/mode/r/r.js'
//import 'codemirror/them/base16-dark.css'
import { codemirror } from 'vue-codemirror'
// require styles
import 'codemirror/lib/codemirror.css'

export default {
  components: {
		QuestionBox,
		codemirror
  },

  data() {
    return {
      questions,
      index: 0,
      numCorrect: 0,
      numTotal: 0,
			ans: "",
			code: '',
			codeGiven: "employee <- c('John Doe','Peter Gynn','Jolie Hope')",
			cmOptions: {
				mode: 'r',
				lineNumbers: true,
				line: true,
			},
			cmReadOnly: {
				lineNumbers: true,
				mode: 'r',
				readOnly: true,
				lineWrapping: true
			}
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
		onCmReady(cm) {
			console.log('the editor is readied!', cm)
		},
		onCmFocus(cm) {
			console.log('the editor is focus!', cm)
		},
		onCmCodeChange(newCode) {
			console.log('this is new code', newCode)
			this.code = newCode
		},
    submitCode: function() {
      const gatewayUrl =
        "https://oo3olpgm5m.execute-api.us-east-1.amazonaws.com/default/tutor_week12";
      console.log("hello world");
      fetch(gatewayUrl, {
        method: "POST",
        // headers: {
        //       Accept: "application/json",
        //       "Content-Type": "application/json"
        //     },
        body: this.code
        // JSON.stringify({ //this.code
        //         userToken: 'dummy_token',
        //         editable: this.code,
        //         hidden: 'dummy_hidden',
        //         shown: 'dummy_shown'})
      })
        .then(response => {
          console.log(response);
          return response.text();
        })
        .then(response => {
          console.log(response.body);
          this.$set(this, "ans", response);
        });
    }
	},
	computed: {
		codemirror() {
			return this.$refs.myCm.codemirror
		}
	},
	mounted () {
		console.log('this is current codemirror object', this.codemirror)
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
<style>
	.CodeMirror { 
		text-align: left; 
		}
	.CodeMirror {
		margin-bottom: 15px;
		}
	.CodeMirror {
		border: 1px solid #eee;
		height: auto;
}
</style>
