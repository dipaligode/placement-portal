<?php
session_start();

// Database connection
$db = new mysqli("localhost", "root", "", "my_placement_portal");

// Check connection
if ($db->connect_error) {
    die("Connection failed: " . $db->connect_error);
}

$message = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $user_id = strtoupper(trim($_POST['username'])); // Convert to uppercase to match format
    $password = $_POST['password'];

    if (empty($user_id) || empty($password)) {
        $message = "User ID and password are required.";
    } else {
        // Extract only the numeric part of the User ID
        $numeric_id = preg_replace("/[^0-9]/", "", $user_id);

        // Determine role based on ID prefix
        if (strpos($user_id, "T") === 0) {
            $role = "teacher_coordinator";
            $table = "teachers";
        } elseif (strpos($user_id, "S") === 0) {
            $role = "student";
            $table = "students";
        } elseif (strpos($user_id, "SC") === 0) {
            $role = "student_coordinator";
            $table = "students"; // Assuming SC also belongs to `students`
        } else {
            $message = "Invalid User ID format.";
            $role = "";
        }

        if (!empty($role)) {
            // Prepare and execute query
            $stmt = $db->prepare("SELECT id, password FROM users WHERE id = ?");
            if ($stmt) {
                $stmt->bind_param("i", $numeric_id); // Bind as integer
                $stmt->execute();
                $stmt->store_result();
                $stmt->bind_result($db_user_id, $hashedPassword);

                if ($stmt->num_rows > 0) {
                    $stmt->fetch();

                    if (password_verify($password, $hashedPassword)) {
                        // Store user details in session
                        $_SESSION['user_id'] = $db_user_id;
                        $_SESSION['role'] = $role;

                        // Update last login time in the corresponding table
                        $updateLogin = $db->prepare("UPDATE $table SET last_login = NOW() WHERE uid = ?");
                        $updateLogin->bind_param("i", $db_user_id);
                        $updateLogin->execute();
                        $updateLogin->close();

                        // Redirect based on role
                        switch ($role) {
                            case "student":
                                header("Location: student/dashboard.php?user_id=" . urlencode($db_user_id));
                                exit();
                            case "teacher_coordinator":
                                header("Location: teacher_coordinator/dashboard.php?user_id=" . urlencode($db_user_id));
                                exit();
                            case "student_coordinator":
                                header("Location: student_coordinator/dashboard.php?user_id=" . urlencode($db_user_id));
                                exit();
                        }
                    } else {
                        $message = "Invalid User ID or password.";
                    }
                } else {
                    $message = "User not found.";
                }
                $stmt->close();
            } else {
                $message = "Database error: " . $db->error;
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>

    <?php if (!empty($message)): ?>
        <p style="color: red;"><?php echo htmlspecialchars($message); ?></p>
    <?php endif; ?>

    <form method="post">
        <label>User ID:</label>
        <input type="text" name="username" required placeholder="Enter User ID"><br><br>

        <label>Password:</label>
        <input type="password" name="password" required placeholder="Enter Password"><br><br>

        <button type="submit">Login</button>
    </form>

    <p><a href="forgot-password.php">Forgot Password?</a></p>
</body>
</html>
