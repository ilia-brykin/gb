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

			<h1>Генератор паролей</h1>

			<div class="box">

<?php

					if(isset($_GET['MIN']) && isset($_GET['MAX'])){


						$str = 'abcdefghijklmnopqstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
						$minPass = $_GET["MIN"];
						$maxPass = $_GET["MAX"];
						$length = rand($minPass,$maxPass);
						$pass = '';
						$num = strlen($str);

							for($i=0;$i<$length;$i++){
							    $char = $str[rand(0,$num)];
							    $pass .= (rand(0,1) == 0 ? strtolower($char) : strtoupper($char));

							}
						echo "Ваш паполь: " . $pass;





												
					}

?>
				<form method="GET">
					<p>Введите наименьшую длинну пароля который вы хотели бы сгенерировать</p>
					<input type="text" name="MIN">

					<p>Введите наибольшую длинну пароля который вы хотели бы сгенерировать</p>
					<input type="text" name="MAX">


					<br>
					<input type="submit" value="Сгенерировать" name="">
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