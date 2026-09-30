<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Leaderboard.aspx.vb" Inherits="LeaderboardPage.Leaderboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Code Runner - Leaderboard</title>

    <style>

        * {
            box-sizing: border-box;
        }

        html,
        body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            font-family: Arial, Helvetica, sans-serif;
            overflow-x: hidden;
        }


        /* =========================================
           MAIN BACKGROUND
           ========================================= */

        body {

            min-height: 100vh;

            background:
                linear-gradient(
                    to bottom,
                    #1d6072 0%,
                    #258a96 45%,
                    #55c7c7 100%
                );

            position: relative;

        }


        /* =========================================
           TOP NAVIGATION BAR
           ========================================= */

        .navbar {

            position: fixed;

            top: 0;
            left: 0;

            width: 100%;

            height: 30px;

            background: #174f63;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 10px;

            z-index: 100;

            box-shadow:
                0 1px 4px rgba(0,0,0,0.25);

        }


        .logo {

            font-size: 12px;

            font-weight: bold;

            color: #ffd21f;

            letter-spacing: 0.2px;

        }


        .logo span {

            color: #24d5bd;

        }


        .nav-right {

            display: flex;

            align-items: center;

            gap: 5px;

        }


        .user-badge {
            display: flex; align-items: center; gap: 8px;
            background: rgba(255, 255, 255, 0.15); padding: 5px 10px; border-radius: 20px;
        }
        .user-avatar { font-size: 11px; color: #4ade80; }
        .username { font-size: 9px; font-weight: 700; color: #ffffff; }


        .logout {

            background: #ff4b4b;

            color: white;

            padding: 3px 10px;

            border-radius: 10px;

            font-size: 8px;

            font-weight: bold;

            text-decoration: none;

        }


        /* =========================================
           LEADERBOARD AREA
           ========================================= */

        .page-container {

            min-height: 100vh;

            padding-top: 24px;

            padding-bottom: 100px;

            display: flex;

            justify-content: center;

            align-items: center;

            position: relative;

            z-index: 10;

        }


        /* =========================================
           LEADERBOARD CARD
           ========================================= */

        .leaderboard-card {

            width: 90%;

            max-width: 650px;

            background: rgba(255,255,255,0.98);

            border-radius: 16px;

            padding: 25px;

            box-shadow:
                0 12px 30px rgba(0,0,0,0.25);

            margin-top: 20px;

        }


        .title {

            text-align: center;

            margin-bottom: 5px;

            color: #12355b;

            font-size: 25px;

            font-weight: 800;

        }


        .subtitle {

            text-align: center;

            color: #777;

            font-size: 11px;

            margin-bottom: 20px;

        }


        /* =========================================
           TABLE HEADER
           ========================================= */

        .table-header {

            display: grid;

            grid-template-columns:
                80px
                1fr
                120px;

            background: #174f63;

            color: white;

            border-radius: 10px;

            padding: 12px 15px;

            font-size: 11px;

            font-weight: bold;

        }


        /* =========================================
           PLAYER ROW
           ========================================= */

        .player-row {

            display: grid;

            grid-template-columns:
                80px
                1fr
                120px;

            align-items: center;

            background: #f4f8fa;

            margin-top: 8px;

            border-radius: 10px;

            padding: 12px 15px;

            color: #12355b;

            font-size: 13px;

            box-shadow:
                0 2px 5px rgba(0,0,0,0.06);

            transition: 0.2s;

        }


        .player-row:hover {

            transform: translateY(-2px);

            box-shadow:
                0 5px 12px rgba(0,0,0,0.12);

        }


        .rank {

            text-align: center;

            font-weight: bold;

        }


        .username-cell {

            font-weight: bold;

        }


        .score {

            text-align: center;

            font-weight: bold;

            color: #ff8c00;

        }


        /* =========================================
           TOP 3
           ========================================= */

        .first {

            background: #fff4cc;

            border: 1px solid #ffd84d;

        }


        .second {

            background: #eeeeee;

            border: 1px solid #cccccc;

        }


        .third {

            background: #f6e2ce;

            border: 1px solid #d8a878;

        }


        .medal {

            font-size: 20px;

        }


        /* =========================================
           LOADING / ERROR
           ========================================= */

        .loading {

            text-align: center;

            padding: 30px;

            color: #777;

            font-size: 13px;

        }


        .error {

            text-align: center;

            padding: 25px;

            color: #e53935;

            font-size: 13px;

            font-weight: bold;

        }


        /* =========================================
           BACK BUTTON
           ========================================= */

        .back-button {

            display: block;

            width: 160px;

            margin: 20px auto 0;

            padding: 10px;

            text-align: center;

            background: #ff8c00;

            color: white;

            text-decoration: none;

            border-radius: 8px;

            font-size: 11px;

            font-weight: bold;

            box-shadow:
                0 4px 8px rgba(0,0,0,0.15);

        }


        .back-button:hover {

            background: #f57c00;

        }


        /* =========================================
           CITY SILHOUETTE
           ========================================= */

        .city {

            position: fixed;

            left: 0;

            bottom: 0;

            width: 100%;

            height: 95px;

            z-index: 2;

            pointer-events: none;

        }


        .ground {

            position: absolute;

            bottom: 0;

            left: 0;

            width: 100%;

            height: 12px;

            background: #174f63;

        }


        .building {

            position: absolute;

            bottom: 12px;

            background: #245c72;

        }


        .building1 {

            left: 4%;

            width: 17px;

            height: 55px;

        }


        .building2 {

            left: 17%;

            width: 21px;

            height: 80px;

        }


        .building3 {

            right: 20%;

            width: 16px;

            height: 65px;

        }


        .building4 {

            right: 8%;

            width: 19px;

            height: 85px;

        }


        .building5 {

            left: 30%;

            width: 12px;

            height: 38px;

        }


        .building6 {

            right: 32%;

            width: 12px;

            height: 45px;

        }


        /* =========================================
           RESPONSIVE
           ========================================= */

        @media(max-width: 600px) {

            .leaderboard-card {

                width: 94%;

                padding: 18px;

            }


            .title {

                font-size: 21px;

            }


            .table-header,
            .player-row {

                grid-template-columns:
                    55px
                    1fr
                    90px;

                padding: 10px;

            }


            .city {

                height: 70px;

            }

        }

    </style>

</head>


<body>


<form id="form1" runat="server">


    <!-- =========================================
         NAVIGATION BAR
         ========================================= -->

    <div class="navbar">

        <div class="logo">

            Code <span>Runner</span>

        </div>


        <div class="nav-right">

            <div class="user-badge">
                    <span class="user-avatar">🎮</span>
                    <asp:Label id="lblUsername" runat="server" CssClass="username" Text="Player"></asp:Label>
                </div>

            <a href="../Login.aspx" class="logout">
                Logout
            </a>

        </div>

    </div>



    <!-- =========================================
         LEADERBOARD
         ========================================= -->

    <div class="page-container">


        <div class="leaderboard-card">


            <div class="title">

                🏆 Leaderboard

            </div>


            <div class="subtitle">

                Top Code Runner Players

            </div>


            <!-- TABLE HEADER -->

            <div class="table-header">

                <div>
                    RANK
                </div>

                <div>
                    PLAYER
                </div>

                <div style="text-align:center;">
                    SCORE
                </div>

            </div>


            <!-- DATA WILL BE LOADED HERE -->

            <div id="leaderboard">

                <div class="loading">

                    Loading leaderboard...

                </div>

            </div>


            <!-- BACK BUTTON -->

            <a href="../Home.aspx" class="back-button">

                ← BACK TO HOME

            </a>


        </div>

    </div>



    <!-- =========================================
         CITY / BUILDINGS
         ========================================= -->

    <div class="city">


        <div class="building building1"></div>

        <div class="building building2"></div>

        <div class="building building3"></div>

        <div class="building building4"></div>

        <div class="building building5"></div>

        <div class="building building6"></div>


        <div class="ground"></div>


    </div>



</form>



<script>


    // =========================================
    // LOAD LEADERBOARD
    // =========================================

    function loadLeaderboard() {


        var leaderboard =
            document.getElementById("leaderboard");


        fetch("http://localhost:3000/api/leaderboard")


            .then(function(response) {


                if (!response.ok) {

                    throw new Error(
                        "Server error"
                    );

                }


                return response.json();


            })


            .then(function(data) {


                if (!data.success) {

                    throw new Error(
                        data.message ||
                        "Unable to load leaderboard."
                    );

                }


                leaderboard.innerHTML = "";


                if (
                    !data.leaderboard ||
                    data.leaderboard.length === 0
                ) {


                    leaderboard.innerHTML =

                        '<div class="loading">' +

                        'No players found.' +

                        '</div>';


                    return;

                }



                data.leaderboard.forEach(
                    function(player) {


                        var row =
                            document.createElement("div");


                        row.className =
                            "player-row";


                        // TOP 3 STYLING

                        if (player.rank === 1) {

                            row.className +=
                                " first";

                        }

                        else if (player.rank === 2) {

                            row.className +=
                                " second";

                        }

                        else if (player.rank === 3) {

                            row.className +=
                                " third";

                        }



                        // RANK

                        var rank =
                            player.rank;


                        if (player.rank === 1) {

                            rank =
                                '<span class="medal">🥇</span>';

                        }

                        else if (player.rank === 2) {

                            rank =
                                '<span class="medal">🥈</span>';

                        }

                        else if (player.rank === 3) {

                            rank =
                                '<span class="medal">🥉</span>';

                        }



                        row.innerHTML =

                            '<div class="rank">' +

                            rank +

                            '</div>' +


                            '<div class="username-cell">' +

                            escapeHtml(
                                player.username
                            ) +

                            '</div>' +


                            '<div class="score">' +

                            player.score +

                            '</div>';


                        leaderboard.appendChild(row);


                    }
                );


            })


            .catch(function(error) {


                console.error(
                    "Leaderboard Error:",
                    error
                );


                leaderboard.innerHTML =

                    '<div class="error">' +

                    'Unable to load leaderboard.<br>' +

                    'Please make sure the Node.js server is running.' +

                    '</div>';


            });

    }



    // =========================================
    // SECURITY
    // =========================================

    function escapeHtml(text) {


        var div =
            document.createElement("div");


        div.textContent =
            text;


        return div.innerHTML;

    }



    // =========================================
    // LOAD USERNAME
    // =========================================

    function loadUsername() {


        var username =
            sessionStorage.getItem("Username");


        if (!username) {

            username =
                localStorage.getItem("Username");

        }


        if (username) {

            document.getElementById(
                "navUsername"
            ).innerHTML =
                escapeHtml(username);

        }

    }



    // =========================================
    // PAGE LOAD
    // =========================================

    window.onload = function() {

        loadUsername();

        loadLeaderboard();

    };


</script>


</body>

</html>