export default [
	{
		question: 'How to import an excel file and assign to a variable? (Show the excel file that is being used to import)?',
		correct_answer: 'a = read_excel("Credit Risk Data.xlsx", skip = 2)',
		incorrect_answers: [
			'read_excel(Credit Risk Data.xlsx)',
			'B = read_excel("Credit Risk Data xlsx")',
			'a = read.csv(Credit Risk Data)'
		]
	},
	{
		question: 'How to export the dataset (df1) as csv file named export?',
		correct_answer: 'write.table(df1, file = "export", sep = ",", row.names = FALSE)',
		incorrect_answers: [
			'write.csv(df1 , file = export, row.names = FALSE)',
			'write.csv(df1, file = ëxport”, sep = “,” , row.names = FALSE)',
			'table(df1, file = "export", sep = ",", row.names = FALSE)'
		]
	},
	{
		question: 'How to retrieve the column vector named "Price", third column from a dataframe(df1)',
		correct_answer: 'd1$Price',
		incorrect_answers: [
			'd1.Price',
			'vector(d1$Price)',
			'vector(df1[,3])'
		]
	},
	{
		question: 'Apply filter on the column vector (where price is a continuous numerical variable.) How to get rows that correspond the price between 50 and 100 inclusive',
		correct_answer: 'df1 %>% filter (Price >= 50 && Price <= 100)',
		incorrect_answers: [
			'subset(df1, Price > 50 && Price < 100]',
			'df1(df1$Price  <= 100 && df1$Price >= 50)',
			'filter(df1, Price >= 50, Price <= 100]'
		]
	}
]
