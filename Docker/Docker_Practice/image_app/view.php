<?php

$servername =  getenv('DATABASE_HOST');
$username =  getenv('DATABASE_USERNAME');
$password =  getenv('DATABASE_PASSWORD');
$dbname = getenv('DATABASE_NAME');
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = 'SELECT * FROM visitors';
$query = mysqli_query($conn, $sql);

while ($info = mysqli_fetch_array($query)) { 
    $photo = $info['photo'];
    $imageSrc = "images/$photo";  // Resimlerin uygulamanızın çalıştığı konteynerdeki yolunu doğru şekilde ayarlayın

    echo "<img src=\"$imageSrc\"><br>"; 
    echo "<b>Foto:</b> $photo <br>";
    echo "<b>Name:</b> ".$info['name'] . "<br>";
    echo "<b>Email:</b> ".$info['email'] . "<br>";
    echo "<b>Phone:</b> ".$info['phone'] . "<hr>";
}

$conn->close();
?>


<?php

