<!DOCTYPE HTML>  
<html>
<title>UVic Geography Program Planning Form</title>
<!-- 
adapted code from 
https://tryphp.w3schools.com/showphp.php?filename=demo_form_validation_complete
2023-01-22
-->
<head>
<style>
    /* Style from DataTable-shiny-to-web-tabs.html */
    body {
      background-color: #fff;
      font-family: sans-serif;
      display: block;
        margin: 8px;
    }
    h2 {
        display: block;
        font-size: 1.5em;
        margin-block-start: 0.83em;
        margin-block-end: 0.83em;
        margin-inline-start: 0px;
        margin-inline-end: 0px;
        font-weight: bold;
    }
    h3 {
        display: block;
        font-size: 1.17em;
        margin-block-start: 1em;
        margin-block-end: 1em;
        margin-inline-start: 0px;
        margin-inline-end: 0px;
        font-weight: bold;
    }
    h4 {
        display: block;
        font-size: 0.9em;
        margin-block-start: 1em;
        margin-block-end: 1em;
        margin-inline-start: 0px;
        margin-inline-end: 0px;
        font-weight: bold;
    }
    footer {
      text-align: center;
      font-size: 75%;
    }
    hr {
      display: block;
      margin: auto;
      width: 100%;   
    }
    #Links li a {
      font-size: .85em;
      color: #69A81D; 
    }
    a {
      font-size: .99em;
      color: #69A81D; 
    }
    
    img { border-style: none; }

/* php form error if required but data not entered */
    .error {color: #FF0000;}

    /* php form styling */
    .note {
      font-size: .95em;
      font-style: italic;
    }
    /* form outer edges
    code from
    https://www.w3schools.com/css/tryit.asp?filename=trycss_forms
     */

    .direction{
      font-weight: bold;
      font-size: 1.1em;
      padding: 2px;
    }
    div {
      border-radius: 5px;
      background-color: #f2f2f2;
      padding: 20px;
    }
    /* when input box is clicked */
    input[type=text]:focus {
      border: 3px solid #69A81D;
    }

    input[type=text], select {
      width: 450px;
      padding: 12px 20px;
      margin: 8px 0;
      display: inline-block;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
    }
/* Doesn't seem to do anything */    
/*  input[type=comment] {
      width: 2  0%; 
      padding: 12px 20px;
      margin: 8px 0;
      display: inline-block;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
    }
*/
/* for all input fields
including date, checkbox and radio buttons and course names
but NOT Comments see textarea */
/*
    input{
      width: 40%;
    }
*/    

    input[type=datetime-local] {
      width: 300px;
      color: black;
      padding: 14px 20px;
      margin: 8px 0;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    input[type=checkbox] {
      width: 45px;
      color: black;
      padding: 14px 20px;
      margin: 8px 0;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    input[type=radio] {
      width: 45px;
      color: black;
      padding: 14px 20px;
      margin: 8px 0;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    input[type=submit] {
      width: 300px;
      font-size: 1.2em;
      background-color: #69A81D;
      color: white;
      padding: 14px 20px;
      margin: 8px 0;
      margin-left: 45px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    input[type=submit]:hover {
      background-color: #45a049;
    }

    .outputHead {
      font-weight: bold;
      font-size: 25px;
    }
    .outputInput {
      font-size: 22px;
    }    
    .outputYear {
      font-weight: bold;
      font-size: 30px;
    }    
    /* vs comment
      https://www.w3schools.com/css/tryit.asp?filename=trycss_form_textarea
     */
    textarea {
      width: 400px;
      /*  when width: 100% Column header is at top right of box
      anything else it ends up at bottom*/
      height: 150px;
      padding: 12px 20px;
      box-sizing: border-box;
      border: 2px solid #ccc;
      border-radius: 4px;
      background-color: #f8f8f8;
      font-size: 16px;
      resize: none;
    }    
</style>
</head>
<body>  

<?php
// define variables and set to empty values
// $nameErr = $emailErr = $genderErr = $websiteErr = "";
// $name = $email = $gender = $comment = $website = "";
$name = $email = $todaysDate = $course1 = $course2 = $course3 = $course4 = $comment = "";

 /* end of if else error php */
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  if (empty($_POST["name"])) {
    $name = "";
  } else {
    $name = test_input($_POST["name"]);
    // check if name only contains letters and whitespace
    if (!preg_match("/^[a-zA-Z-' ]*$/",$name)) {
      $nameErr = "Only letters and white space allowed";
    }
  }

/*  if ($_SERVER["REQUEST_METHOD"] == "POST") {
  if (empty($_POST["name"])) {
    $nameErr = "Name is required";
  } else {
    $name = test_input($_POST["name"]);
    // check if name only contains letters and whitespace
    if (!preg_match("/^[a-zA-Z-' ]*$/",$name)) {
      $nameErr = "Only letters and white space allowed";
    }
  }
*/  

  if (empty($_POST["email"])) {
    $email = "";
  } else {
    $email = test_input($_POST["email"]);
    // check if e-mail address is well-formed
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
      $emailErr = "Invalid email format";
    }
  }

/*  if (empty($_POST["email"])) {
    $emailErr = "Email is required";
  } else {
    $email = test_input($_POST["email"]);
    // check if e-mail address is well-formed
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
      $emailErr = "Invalid email format";
    }
  }
*/ 

/*    
  if (empty($_POST["website"])) {
    $website = "";
  } else {
    $website = test_input($_POST["website"]);
    // check if URL address syntax is valid (this regular expression also allows dashes in the URL)
    if (!preg_match("/\b(?:(?:https?|ftp):\/\/|www\.)[-a-z0-9+&@#\/%?=~_|!:,.;]*[-a-z0-9+&@#\/%=~_|]/i",$website)) {
      $websiteErr = "Invalid URL";
    }
  }
*/

/*  if (empty($_POST["gender"])) {
    $genderErr = "Gender is required";
  } else {
    $gender = test_input($_POST["gender"]);
  }
*/

    if (empty($_POST["todaysDate"])) {
    $todaysDate = "";
  } else {
    $todaysDate = test_input($_POST["todaysDate"]);
  }


    if (empty($_POST["course1"])) {
    $course1 = "";
  } else {
    $course1 = test_input($_POST["course1"]);
  }

    if (empty($_POST["course2"])) {
    $course2 = "";
  } else {
    $course2 = test_input($_POST["course2"]);
  }

    if (empty($_POST["course3"])) {
    $course3 = "";
  } else {
    $course3 = test_input($_POST["course3"]);
  }

    if (empty($_POST["course4"])) {
    $course4 = "";
  } else {
    $course4 = test_input($_POST["course4"]);
  }

    if (empty($_POST["comment"])) {
    $comment = "";
  } else {
    $comment = test_input($_POST["comment"]);
  }

} /* end of if else error php */

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
?>

<h2>UVic Geography Program Planning Form <img src="https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Martlet-SocialSciences-transparent.png" alt="UVic Martlet icon" height = 50></h2>
  <img src="https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png" alt="UVic Dynamic Edge Stripe" height = 50 width = "100%">

<div> <!-- form begins -->
    <!--<p><span class="error">* required field</span></p> -->

<!--
<form method="post" name="myemailform" action="form-to-email.php">

Enter Name: <input type="text" name="name">

Enter Email Address:  <input type="text" name="email">

Enter Message:  <textarea name="message"></textarea>

<input type="submit" value="Send Form">
</form>
-->    
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">  
  <strong>Name:</strong> <input type="text" name="name" value="<?php echo $name;?>">
    <!--  <span class="error">* <?php echo $nameErr;?></span> -->
  <br><br>
  <strong>E-mail:</strong> <input type="text" name="email" value="<?php echo $email;?>">
  <!-- <span class="error">* <?php echo $emailErr;?></span> -->
  <br><br>
    <!--  Website: <input type="text" name="website" value="<?php echo $website;?>">
      <span class="error"><?php echo $websiteErr;?></span>
      <br><br>
     -->
  <strong>Today's Date:</strong> <input type="datetime-local" class="date" name="todaysDate" value="<?php echo $todaysDate;?>">
  <br><br> 
  <h2>Year 1 Course Requirements:</h2>
  <span class="note">(Note: click course name to open Calendar listing)</span>
  <br><br>
  <input type="checkbox" name="course1" <?php if (isset($course1) && $course1=="geog101b") echo "checked";?> value="GEOG 101B"><a href="https://www.uvic.ca/calendar/future/undergrad/index.php#/courses/H1-GBOaXN?bc=true&bcCurrent=Space%2C%20Place%20and%20Society&bcGroup=Geography%20(GEOG)&bcItemType=Courses" target="_blank">GEOG 101B</a>
  <br>
  <input type="checkbox" name="course2" <?php if (isset($course2) && $course2=="geog103") echo "checked";?> value="GEOG 103"><a href="https://www.uvic.ca/calendar/future/undergrad/index.php#/courses/SJMzBua7N?bc=true&bcCurrent=Introduction%20to%20Physical%20Geography&bcGroup=Geography%20(GEOG)&bcItemType=Courses" target="_blank">GEOG 103</a>
  <br><br>
  <span class="direction">Choose 1 course from</span><br>
  <input type="radio" name="course3" <?php if (isset($course3) && $course3=="geog101a") echo "checked";?> value="GEOG 101A"><a href="https://www.uvic.ca/calendar/future/undergrad/index.php#/courses/H1bzS_67E?bc=true&bcCurrent=Environment%2C%20Society%20and%20Sustainability&bcGroup=Geography%20(GEOG)&bcItemType=Courses" target="_blank">GEOG 101A</a>
  <br>
  <input type="radio" name="course3" <?php if (isset($course3) && $course3=="geog104") echo "checked";?> value="GEOG 104"><a href="https://www.uvic.ca/calendar/future/undergrad/index.php#/courses/HkUg06FiH?bc=true&bcCurrent=Our%20Digital%20Earth&bcGroup=Geography%20(GEOG)&bcItemType=Courses" target="_blank">GEOG 104</a>
  <br><br>

  <strong>Comments:</strong> <textarea name="comment" class="comment" rows="5" cols="30"><?php echo $comment;?></textarea>
  <br><br>

  <input type="submit" name="submit" class="submit" value="Submit to Print Below">  
</form>
</div> <!-- form ends -->


<br>
<hr>

<?php
echo "<h2>Your Course Info Input:</h2>";
echo "<span class='outputHead'>Your Name: </span>";
echo $name;
echo "<br>";
echo "<span class='outputHead'>Your Email: </span>";
echo $email;
echo "<br>";
echo "<span class='outputHead'>Today's Date: </span>";
echo $todaysDate;
echo "<br>";
echo "<br>";
echo "<span class='outputYear'>Year 1:</span>";
echo "<br>";
echo "<span class='outputHead'>Required Course 1: </span>";
echo $course1;
echo "<br>";
echo "<span class='outputHead'>Required Course 2: </span>";
echo $course2;
echo "<br>";
echo "<span class='outputHead'>Required Course 3: </span>";
echo $course3;
echo "<br>";
//echo "<strong>Required Course 4: </strong>";
//echo $course4;
echo "<br>";
echo "<span class='outputHead'>Comments: </span>";
echo $comment;
echo "<br>";
?>

<br><br>
<img src="https://people.geog.uvic.ca/wanthony/website/geog-curriculum-maps/images/Dynamic-edge-transparent-1.png" alt="UVic Dynamic Edge Stripe" height = 50 width = "100%">

</body>
</html>