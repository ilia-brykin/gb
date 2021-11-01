<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Личный сайт студента GeekBrains</title>
	<link rel="stylesheet" href="style.css"> 
	
</head>
<body>

<div class="content">
	<?php 
 	include "menu.php";
	?>
<div class="contentWrap">
    <div class="content">
        <div class="center">

			<h1>Игра в загадки</h1>

			<div class="box">
				

				<?php

					if(isset($_GET['userAnswer1']) && isset($_GET['userAnswer2']) && isset($_GET['userAnswer3']) && isset($_GET['userAnswer4'])){


						$userAnswer = $_GET["userAnswer1"];
						$score = 0;
						if($userAnswer == "галоши" || $userAnswer == "Галоши"  ){ 
							$score++;
						}

						$userAnswer = $_GET["userAnswer2"];

						if($userAnswer == "ель" || $userAnswer == "ёлка"  ){ 
							$score++;
						}

						$userAnswer = $_GET["userAnswer3"];

						if($userAnswer == "одно" || $userAnswer == "Одно"  ){ 
							$score++;
						}

						$userAnswer = $_GET["userAnswer4"];

						if($userAnswer == "лук" || $userAnswer == "капуста"  ){ 
							$score++;
						}

						echo "Вы угадали " . $score . " загадок";
					}

				?>

				<form method="GET">
					<p>Свеху черное внутри красное, как оденешь так прекрасное. Что это?</p>
					<input type="text" name="userAnswer1">

					<p>Зимой и летом одним цветом. Что это?</p>
					<input type="text" name="userAnswer2">

					<p>Сколько яиц можно съесть натощак?</p>
					<input type="text" name="userAnswer3">

					<p>Сто одёжек и все без застёжек. Что это?</p>
					<input type="text" name="userAnswer4">

					<br>
					<input type="submit" value="Ответить" name="">
				</form>
				

			</div>

        </div>
    </div>
</div>

	

</div>
<div class="footer">
	Copyright &copy; <?php echo date ("Y");?> Anton Mukhortov
<div>


</body>
</html>