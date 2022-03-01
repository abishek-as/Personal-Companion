# About the project

The requirement for numerous functions in a single app is expanding and becoming important as the number of apps increases and challenges with maintainability and storage arise. "Personal Companion," the proposed solution, contains tools for keeping track of spending, taking notes, and calculating the user's steps. The database is SQLite, and the program is created with flutter. Flutter makes developing cross-platform apps simple. Flutter was the ideal choice for our solution because it is available on numerous platforms and has a shorter time to market. The expense tracker function is designed to keep track of spending by allowing users to enter transactions and generate bar charts that show the percentage of total expenses. The pedometer plugin is also used to calculate steps. It will also have goals (for motivating the user). Note-taking gives us a quick and simple notepad editing experience when we write notes, memos, emails, messages, shopping lists, and to-do lists.

## To run this project you need

- Visual Studio Code
- Flutter

## Features of the App

1. We must manually enable Physical Activity Permission in Android after installing the app (This is applicable If the device is android 10 else no permission need).
2. The homepage displays a step counter that displays the number of steps taken as well as the status of the user's movement, such as walking or stopping. To begin, the status to loading to obtain status information. The homepage also includes the buttons Take Notes and Add Expenses, which, when clicked, take you to the Notes and Expenses Page.
3. When you click the Add Notes button, you'll be taken to the Notes home page, which lists all of the notes in the app database. To add notes, click the button in the bottom right corner of the screen, which will take you to a page where you may input a title, a description for the notes, and other information.
4. After adding new notes, they are displayed on the notes home page in a distinct color, ensuring that they are kept in the database.
5. When you click the Add Expenses button, the Personal Expenses page appears, displaying all of your previously saved expenses in a nice bar graph. The bar graph depicts the expenses incurred on a specific weekday. It also displays a stacked list of all transactions
6. To add a new expense, go to the bottom of the page and click the button. This will take you to a page where you can enter the transaction's title, amount, date, and time.
7. When you click the Add Transaction button, the expense is saved in the database, and the amount is added to the expense of the week in the bar chart. The transaction is also added to the list of other transactions and displayed on the Personal Expenses page.
8. So that's how our app works.

## Screenshots

- App Permissions.
  <img src="/screenshots/15.jpg" width=270 height=480>
- The home page and the steps, as well as the status of the user’s movement.
<table>
    <tr>
    <td><img src="/screenshots/1.jpg" width=270 height=480></td>
    <td><img src="/screenshots/2.jpg" width=270 height=480></td>
    <td><img src="/screenshots/3.jpg" width=270 height=480></td>
    </tr>
</table>
- Notes home page and adding new notes.
<table>
    <tr>
    <td><img src="/screenshots/4.jpg" width=270 height=480></td>
    <td><img src="/screenshots/16.jpg" width=270 height=480></td>
    <td><img src="/screenshots/18.jpg" width=270 height=480></td>
    </tr>
</table>
- Displaying the notes after adding the new note.
<table>
    <tr>
    <td><img src="/screenshots/17.jpg" width=270 height=480></td>
    <td><img src="/screenshots/19.jpg" width=270 height=480></td>
    <td><img src="/screenshots/5.jpg" width=270 height=480></td>
    </tr>
</table>
- Displaying the personal expenses page, add transactions widget.
<table>
    <tr>
    <td><img src="/screenshots/8.jpg" width=270 height=480></td>
    <td><img src="/screenshots/9.jpg" width=270 height=480></td>
    <td><img src="/screenshots/10.jpg" width=270 height=480></td>
    </tr>
</table>
- Adding transaction details and other necessary information.
<table>
    <tr>
    <td><img src="/screenshots/11.jpg" width=270 height=480></td>
    <td><img src="/screenshots/12.jpg" width=270 height=480></td>
    <td><img src="/screenshots/13.jpg" width=270 height=480></td>
    </tr>
</table>
- Personal Expenses page after adding the expenses.
  <img src="/screenshots/14.jpg" width=270 height=480>
