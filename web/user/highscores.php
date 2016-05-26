<?php
$title = "Highscores";
include 'header.php';

$columns = "<th>Username</th><th>Games Won</th><th>Games Lost</th>";
?>

<div class="container-fluid">
<div class="side-body">
<div class="page-title">
    <span class="title"><?php echo $title; ?></span>
    <div class="description">Here you can view the highscores for a specific category.</div>
</div>
<div class="row">
    <div class="col-xs-12">
        <div class="card">
            <div class="card-header">

                <div class="card-title">
                <div class="title">Table</div>
                </div>
            </div>
            <div class="card-body">
                <table class="datatable table table-striped" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <?php echo $columns; ?>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <?php echo $columns; ?>
                        </tr>
                    </tfoot>
                    <tbody>
                    <?php
                    $query = "SELECT * FROM users";
                    $result = $db->query($query);
                    while ($fetch = $result->fetch_object()) {
                    echo "
                        <tr>
                            <td>{$fetch->username}</td>
                            <td>{$fetch->wins}</td>
                            <td>{$fetch->losses}</td>
                        </tr>
                        ";
                    }
                    ?>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php include 'footer.php'; ?>