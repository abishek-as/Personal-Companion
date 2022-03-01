# About the project
The requirement for numerous functions in a single app is expanding and becoming important as the number of apps increases and challenges with maintainability and storage arise. "Personal Companion," the proposed solution, contains tools for keeping track of spending, taking notes, and calculating the user's steps. The database is SQLite, and the program is created with flutter. Flutter makes developing cross-platform apps simple. Flutter was the ideal choice for our solution because it is available on numerous platforms and has a shorter time to market. The expense tracker function is designed to keep track of spending by allowing users to enter transactions and generate bar charts that show the percentage of total expenses. The pedometer plugin is also used to calculate steps. It will also have goals (for motivating the user). Note-taking gives us a quick and simple notepad editing experience when we write notes, memos, emails, messages, shopping lists, and to-do lists.

## To run this project you need :
- Visual Studio Code
- Flutter

# Features of the App
1. We must manually enable Physical Activity Permission in Android after installing the app (This is applicable If the device is android 10 else no permission need).
2. The homepage displays a step counter that displays the number of steps taken as well as the status of the user's movement, such as walking or stopping. To begin, the status to loading to obtain status information. The homepage also includes the buttons Take Notes and Add Expenses, which, when clicked, take you to the Notes and Expenses Page.
3. When you click the Add Notes button, you'll be taken to the Notes home page, which lists all of the notes in the app database. To add notes, click the button in the bottom right corner of the screen, which will take you to a page where you may input a title, a description for the notes, and other information.
4. After adding new notes, they are displayed on the notes home page in a distinct color, ensuring that they are kept in the database.
5. When you click the Add Expenses button, the Personal Expenses page appears, displaying all of your previously saved expenses in a nice bar graph. The bar graph depicts the expenses incurred on a specific weekday. It also displays a stacked list of all transactions
6. To add a new expense, go to the bottom of the page and click the button. This will take you to a page where you can enter the transaction's title, amount, date, and time.
7. When you click the Add Transaction button, the expense is saved in the database, and the amount is added to the expense of the week in the bar chart. The transaction is also added to the list of other transactions and displayed on the Personal Expenses page.
8. So that's how our app works.

# Screenshots
- App Permissions
- The home page and the steps, as well as the status of the user’s movement 
- Notes home page and adding new notes 
- Displaying the notes after adding the new note. 
- Displaying the personal expenses page, add transactions widget 
- Adding transaction details and other necessary information. 
- Personal Expenses page after adding the expenses 
