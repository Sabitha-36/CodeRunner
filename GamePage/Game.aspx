<%@ Page Language="VB"
    AutoEventWireup="false"
    CodeFile="Game.aspx.vb"
    Inherits="GamePage.Game" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Code Runner - Game</title>

    <style type="text/css">

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html,
        body {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(
                180deg,
                #184c63 0%,
                #2f9ea6 45%,
                #58cdc9 100%
            );
        }

        /* ==========================================
           TOP HEADER
        ========================================== */

        .top-bar {

            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 40px;

            background: #1a4258;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 18px;

            z-index: 100;

            box-shadow:
                0 2px 8px rgba(0,0,0,0.20);
        }
         
        .brand {
            font-size: 19px;
            font-weight: 900;
        }

        .yellow {
            color: #facc15;
        }

        .green {
            color: #4ade80;
        }
        
        .username {
            font-size: 18px;
            font-weight: bold;
            color: White;
        }
        .nav-right { display: flex; align-items: center; gap: 15px; }
        .user-badge {
            display: flex; align-items: center; gap: 8px;
            background: rgba(255, 255, 255, 0.15); padding: 5px 14px; border-radius: 20px;
        }
        .user-avatar { font-size: 16px; color: #4ade80; }
        .user-name { font-size: 13px; font-weight: 700; color: #ffffff; }

        .level-info {
            color: white;
            font-size: 11px;
            font-weight: 900;
            text-transform: uppercase;
        }

        /* ==========================================
           GAME CONTAINER
        ========================================== */

        .game-container {

            position: absolute;

            top: 40px;
            left: 0;
            right: 0;
            bottom: 0;

            display: flex;

            justify-content: center;
            align-items: center;
        }

        /* ==========================================
           ROAD
        ========================================== */

        .road {

            position: relative;

            width: 675px;
            height: 450px;

            background:
                linear-gradient(
                    180deg,
                    #54c8c5 0%,
                    #39a9ae 55%,
                    #23798c 100%
                );

            border-radius: 17px;

            overflow: hidden;

            box-shadow:
                0 15px 35px rgba(0,0,0,0.30);
        }

        /* ==========================================
           GAME HUD
        ========================================== */

        .game-hud {

            position: absolute;

            top: 0;
            left: 0;

            width: 100%;
            height: 44px;

            background: #1d4a60;

            display: grid;

            grid-template-columns:
                1fr
                1fr
                1fr
                1fr;

            align-items: center;

            z-index: 50;
        }

        .hud-item {

            text-align: center;

            color: white;

            font-size: 9px;

            font-weight: 900;
        }

        .hud-label {

            display: block;

            font-size: 7px;

            color: #9bd5dc;

            margin-bottom: 2px;

            text-transform: uppercase;
        }

        .hud-value {

            font-size: 11px;

            color: white;
        }

        .heart {

            color: #ff3f6c;

            font-size: 12px;

            letter-spacing: 2px;
        }

        /* ==========================================
           LANES
        ========================================== */

        .lane-line {

            position: absolute;

            top: 44px;
            bottom: 0;

            width: 1px;

            border-left:
                1px dashed rgba(255,255,255,0.40);

            z-index: 3;
        }

        .lane-line.one {
            left: 33.33%;
        }

        .lane-line.two {
            left: 66.66%;
        }

        /* ==========================================
           CITY BUILDINGS
        ========================================== */

        .building {

            position: absolute;

            bottom: 0;

            background: rgba(29,73,91,0.75);

            z-index: 2;
        }

        .building.one {

            left: 0;

            width: 62px;
            height: 115px;
        }

        .building.two {

            left: 100px;

            width: 53px;
            height: 165px;
        }

        .building.three {

            right: 100px;

            width: 49px;
            height: 136px;
        }

        .building.four {

            right: 20px;

            width: 41px;
            height: 175px;
        }

        /* ==========================================
           PLAYER
        ========================================== */

        .player {

            position: absolute;

            bottom: 20px;

            width: 55px;
            height: 65px;

            display: flex;

            align-items: center;
            justify-content: center;

            font-size: 38px;

            z-index: 40;

            transition:
                left 0.12s ease;
        }

        /* ==========================================
           NORMAL CODE TOKEN
        ========================================== */

        .code-token {

            position: absolute;

            min-width: 58px;
            max-width: 130px;

            padding: 7px 9px;

            background: #ffffff;

            color: #17202a;

            border:
                2px solid #4ade80;

            border-radius: 8px;

            text-align: center;

            font-family: Consolas, monospace;

            font-size: 11px;

            font-weight: 900;

            white-space: nowrap;

            box-shadow:
                0 5px 12px rgba(0,0,0,0.30);

            z-index: 20;
        }

        /* ==========================================
           BUG TOKEN
        ========================================== */

        .bug-token {

            position: absolute;

            min-width: 58px;
            max-width: 125px;

            padding: 7px 9px;

            background: #ff4d4d;

            color: white;

            border:
                2px solid #991b1b;

            border-radius: 8px;

            text-align: center;

            font-family: Consolas, monospace;

            font-size: 10px;

            font-weight: 900;

            white-space: nowrap;

            box-shadow:
                0 5px 12px rgba(0,0,0,0.35);

            z-index: 20;
        }

        /* ==========================================
           START SCREEN
        ========================================== */

        .start-screen {

            position: absolute;

            inset: 0;

            background:
                rgba(15,23,42,0.74);

            display: flex;

            flex-direction: column;

            align-items: center;

            justify-content: center;

            z-index: 90;
        }

        .start-title {

            color: white;

            font-size: 30px;

            font-weight: 900;

            margin-bottom: 8px;
        }

        .start-description {

            color: #dbeafe;

            font-size: 12px;

            margin-bottom: 20px;
        }

        .start-button {

            padding: 11px 35px;

            border: none;

            border-radius: 9px;

            background:
                linear-gradient(
                    180deg,
                    #ff9800,
                    #f57c00
                );

            color: white;

            font-size: 14px;

            font-weight: 900;

            cursor: pointer;

            box-shadow:
                0 5px 12px rgba(0,0,0,0.25);
        }

        .start-button:hover {

            background:
                linear-gradient(
                    180deg,
                    #fb8c00,
                    #e65100
                );
        }

        /* ==========================================
           GAME MESSAGE
        ========================================== */

        .game-message {

            position: absolute;

            inset: 0;

            background:
                rgba(15,23,42,0.82);

            display: none;

            align-items: center;

            justify-content: center;

            flex-direction: column;

            z-index: 80;

            color: white;

            text-align: center;
        }

        .game-message h2 {

            font-size: 25px;

            margin-bottom: 8px;
        }

        .game-message p {

            font-size: 13px;
        }

        /* ==========================================
           CONTROLS
        ========================================== */

        .controls {

            position: absolute;

            bottom: 8px;

            left: 50%;

            transform:
                translateX(-50%);

            background:
                rgba(15,23,42,0.85);

            color: white;

            padding: 4px 10px;

            border-radius: 12px;

            font-size: 8px;

            font-weight: 700;

            z-index: 60;

            white-space: nowrap;
        }

        /* ==========================================
           RESPONSIVE
        ========================================== */

        @media screen and (max-width: 720px) {

            .road {

                width: 94vw;

                height: 60vh;
            }
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <!-- SERVER VALUES -->

    <asp:HiddenField
        ID="hiddenLevel"
        runat="server" />

    <asp:HiddenField
        ID="hiddenLevelTokens"
        runat="server" />

    <asp:HiddenField
        ID="hiddenCollectedTokens"
        runat="server" />

        <asp:HiddenField
    ID="hiddenScore"
    runat="server" />

<asp:HiddenField
    ID="hiddenLives"
    runat="server" />

    <!-- TOP BAR -->

    <div class="top-bar">

        <div class="brand">

            <span class="yellow">Code</span>
            <span class="green">Runner</span>

        </div>
        <div class="nav-right">
                <div class="user-badge">
                    <span class="user-avatar">🎮</span>
                    <asp:Label id="lblUsername" runat="server" CssClass="user-name" Text="Player"></asp:Label>
                </div>
        <asp:Label ID="lblLevel"  runat="server" CssClass="level-info">      </asp:Label>
        </div>
    </div>


    <!-- GAME -->

    <div class="game-container">

        <div id="road"
             class="road">


            <!-- HUD -->

            <div class="game-hud">

                <div class="hud-item">

                    <span class="hud-label">
                        SCORE
                    </span>

                    <span
                        id="scoreText"
                        class="hud-value">
                        0
                    </span>

                </div>


                <div class="hud-item">

                    <span class="hud-label">
                        LEVEL
                    </span>

                    <span
                        id="levelText"
                        class="hud-value">
                        1
                    </span>

                </div>


                <div class="hud-item">

                    <span class="hud-label">
                        LIVES
                    </span>

                    <span
                        id="livesText"
                        class="heart">
                        ♥ ♥ ♥
                    </span>

                </div>


                <div class="hud-item">

                    <span class="hud-label">
                        CODE
                    </span>

                    <span
                        id="codeText"
                        class="hud-value">
                        0 / 0
                    </span>

                </div>

            </div>


            <!-- LANES -->

            <div class="lane-line one"></div>
            <div class="lane-line two"></div>


            <!-- BUILDINGS -->

            <div class="building one"></div>
            <div class="building two"></div>
            <div class="building three"></div>
            <div class="building four"></div>


            <!-- PLAYER -->

            <div id="player"
                 class="player">

                🏃

            </div>


            <!-- START SCREEN -->

            <div id="startScreen"
                 class="start-screen">

                <div class="start-title">

                    CODE RUNNER

                </div>

                <div class="start-description">

                    Catch the correct code and avoid bugs!

                </div>

                <button
                    type="button"
                    id="startButton"
                    class="start-button">

                    START RUN 🚀

                </button>

            </div>


            <!-- GAME MESSAGE -->

            <div
                id="gameMessage"
                class="game-message">

                <h2 id="messageTitle">
                    RUN COMPLETE
                </h2>

                <p id="messageText">
                    Opening Challenge...
                </p>

            </div>


            <!-- CONTROLS -->

            <div class="controls">

                ← → or A / D to change lanes

            </div>

        </div>

    </div>


    <!-- SERVER BUTTON -->

    <asp:Button
        ID="btnGameEnded"
        runat="server"
        Text="Game Ended"
        Style="display:none;"
        OnClick="btnGameEnded_Click" />


    <!-- JAVASCRIPT -->

    <script type="text/javascript">

        var currentLevel = 1;

        var tokens = [];

        var collectedTokens = [];

        var score = 0;

        var lives = 3;

        var gameRunning = false;

        var gameFinished = false;

        var playerLane = 1;

        var tokenIndex = 0;

        var activeObjects = [];

        var gameTimer = null;


        /* ==========================================
        LOAD DATA
        ========================================== */

        function loadGameData() {

            var levelField =
                document.getElementById(
                    '<%= hiddenLevel.ClientID %>'
                );

            var tokenField =
                document.getElementById(
                    '<%= hiddenLevelTokens.ClientID %>'
                );


            if (levelField &&
                levelField.value !== "") {

                currentLevel =
                    parseInt(
                        levelField.value,
                        10
                    );
            }


            if (isNaN(currentLevel)) {

                currentLevel = 1;

            }


            if (tokenField &&
                tokenField.value !== "") {

                try {

                    tokens =
                        JSON.parse(
                            tokenField.value
                        );

                }
                catch (error) {

                    console.log(
                        "Token JSON error:",
                        error
                    );

                    tokens = [];

                }

            }


            document.getElementById(
                "levelText"
            ).innerText =
                currentLevel;


            document.getElementById(
                "codeText"
            ).innerText =
                "0 / " +
                tokens.length;


            console.log(
                "LEVEL:",
                currentLevel
            );

            console.log(
                "TOKENS:",
                tokens
            );

        }


       
        /* ==========================================
        PLAYER
        ========================================== */

        function positionPlayer() {

            var player =
                document.getElementById(
                    "player"
                );

            var road =
                document.getElementById(
                    "road"
                );


            if (!player ||
                !road) {

                return;

            }


            var laneWidth =
                road.clientWidth / 3;


            var playerWidth =
                55;


            var left =
                (playerLane * laneWidth)
                +
                ((laneWidth - playerWidth) / 2);


            player.style.left =
                left + "px";

        }


        /* ==========================================
        KEYBOARD
        ========================================== */

        document.addEventListener(
            "keydown",
            function (event) {

                if (!gameRunning) {

                    return;

                }


                var key =
                    event.key.toLowerCase();


                if (
                    event.key === "ArrowLeft" ||
                    key === "a"
                ) {

                    if (playerLane > 0) {

                        playerLane--;

                        positionPlayer();

                    }

                    event.preventDefault();

                }


                if (
                    event.key === "ArrowRight" ||
                    key === "d"
                ) {

                    if (playerLane < 2) {

                        playerLane++;

                        positionPlayer();

                    }

                    event.preventDefault();

                }

            }
        );


        /* ==========================================
        GET LANE POSITION
        ========================================== */

        function getLaneLeft(
            lane,
            objectWidth
        ) {

            var road =
                document.getElementById(
                    "road"
                );


            var laneWidth =
                road.clientWidth / 3;


            return (
                lane * laneWidth
                +
                (laneWidth - objectWidth) / 2
            );

        }


        /* ==========================================
        COUNT ACTIVE BUGS
        ========================================== */

        function getActiveBugCount() {

            var count = 0;

            for (
                var i = 0;
                i < activeObjects.length;
                i++
            ) {

                if (
                    activeObjects[i] &&
                    activeObjects[i].className ===
                    "bug-token"
                ) {

                    count++;

                }

            }

            return count;

        }


        /* ==========================================
        CORRECT CODE TOKEN
        ========================================== */
        /* ==========================================
        GAME FLOW SETTINGS
        ========================================== */

        var codeSpawnTimer = null;
        var bugSpawnTimer = null;


        /* ==========================================
        CORRECT CODE FLOW
        ========================================== */

        function startCodeFlow() {

            if (codeSpawnTimer) {

                clearInterval(codeSpawnTimer);

            }


            /*
            * A new code enters the road
            * every 1.8 seconds.
            */

            spawnCorrectToken();


            codeSpawnTimer =
        setInterval(
            function () {

                if (!gameRunning ||
                    gameFinished) {

                    return;

                }

                spawnCorrectToken();

            },
            1800
        );

        }


        /* ==========================================
        BUG FLOW
        ========================================== */

        function startBugFlow() {

            if (bugSpawnTimer) {

                clearInterval(bugSpawnTimer);

            }


            /*
            * Bugs enter the road every 2.8 seconds.
            *
            * This makes the road contain
            * more codes than bugs.
            */

            bugSpawnTimer =
        setInterval(
            function () {

                if (!gameRunning ||
                    gameFinished) {

                    return;

                }

                /*
                * 70% chance of creating
                * a bug each cycle.
                */

                if (Math.random() < 0.70) {

                    spawnBugToken();

                }

            },
            2800
        );

        }


        /* ==========================================
        START GAME
        ========================================== */

        function startGame() {

            if (!tokens ||
        tokens.length === 0) {

                alert(
            "No code tokens were received from the Level page."
        );

                return;

            }


            document.getElementById(
        "startScreen"
    ).style.display =
        "none";


            gameRunning = true;

            gameFinished = false;

            score = 0;

            lives = 3;

            playerLane = 1;

            tokenIndex = 0;

            collectedTokens = [];

            activeObjects = [];


            updateStats();

            positionPlayer();


            /*
            * Start BOTH flows together.
            */

            startCodeFlow();

            startBugFlow();

        }


        /* ==========================================
        CORRECT CODE
        ========================================== */

        function spawnCorrectToken() {

            if (!gameRunning ||
        gameFinished) {

                return;

            }


            /*
            * All codes have been generated.
            */

            if (tokenIndex >= tokens.length) {

                return;

            }


            var token =
        document.createElement(
            "div"
        );


            token.className =
        "code-token";


            /*
            * Support normal string tokens.
            */

            if (
        typeof tokens[tokenIndex] ===
        "string"
    ) {

                token.innerText =
            tokens[tokenIndex];

            }

            /*
            * Support object tokens.
            */

            else {

                token.innerText =
            tokens[tokenIndex].text ||
            tokens[tokenIndex].token ||
            "";

            }


            /*
            * Random lane.
            */

            var lane =
        Math.floor(
            Math.random() * 3
        );


            token.dataset.lane =
        lane;


            token.dataset.correct =
        "true";


            token.dataset.tokenIndex =
        tokenIndex;


            token.style.left =
        getLaneLeft(
            lane,
            65
        ) + "px";


            token.style.top =
        "50px";


            document
        .getElementById("road")
        .appendChild(token);


            activeObjects.push(token);


            /*
            * IMPORTANT:
            * Move tokenIndex here.
            *
            * This allows the next code
            * to spawn without waiting.
            */

            tokenIndex++;


            animateObject(
        token,
        true
    );

        }


        /* ==========================================
        BUG TOKEN
        ========================================== */

        function spawnBugToken() {

            if (!gameRunning ||
        gameFinished) {

                return;

            }


            var bugList = [

        "BUG",
        "ERROR",
        "a * b",
        "x = -5",
        "print(x",
        "if x >",
        "a + c",
        "return 0",
        "10 / 0",
        "wrong"

    ];


            var bug =
        document.createElement(
            "div"
        );


            bug.className =
        "bug-token";


            bug.innerText =
        bugList[
            Math.floor(
                Math.random() *
                bugList.length
            )
        ];


            /*
            * Random lane.
            */

            var lane =
        Math.floor(
            Math.random() * 3
        );


            bug.dataset.lane =
        lane;


            bug.dataset.correct =
        "false";


            bug.style.left =
        getLaneLeft(
            lane,
            65
        ) + "px";


            bug.style.top =
        "50px";


            document
        .getElementById("road")
        .appendChild(bug);


            activeObjects.push(bug);


            /*
            * Same speed as code.
            */

            animateObject(
        bug,
        false
    );

        }


        /* ==========================================
        OBJECT ANIMATION
        ========================================== */

        function animateObject(
    object,
    isCorrect
) {

            var top = 50;


            /*
            * SAME FLOW SPEED
            *
            * Code and bugs travel together.
            */

            var speed = 1.35;


            var timer =
        setInterval(
            function () {

                if (!gameRunning ||
                    gameFinished) {

                    clearInterval(timer);

                    return;

                }


                top += speed;


                object.style.top =
                    top + "px";


                /*
                * Collision
                */

                if (
                    checkCollision(
                        object
                    )
                ) {

                    clearInterval(
                        timer
                    );


                    if (isCorrect) {

                        collectCorrectToken(
                            object
                        );

                    }

                    else {

                        hitBug(
                            object
                        );

                    }


                    return;

                }


                /*
                * Object reached bottom.
                */

                if (
                    top >
                    document
                        .getElementById(
                            "road"
                        )
                        .clientHeight
                ) {

                    clearInterval(
                        timer
                    );


                    removeObject(
                        object
                    );


                    /*
                    * Missing a code
                    * costs one life.
                    */

                    if (isCorrect) {

                        loseLife();

                    }

                }

            },
            20
        );

        }


        /* ==========================================
        COLLECT CORRECT CODE
        ========================================== */

        function collectCorrectToken(
    object
) {

            if (!object) {

                return;

            }


            var value =
        object.innerText;


            collectedTokens.push(
        value
    );


            score += 10;


            removeObject(
        object
    );


            updateStats();


            /*
            * Check whether all codes
            * have been collected.
            */

            if (
        collectedTokens.length >=
        tokens.length
    ) {

                finishGame();

            }

        }


        /* ==========================================
        STOP GAME FLOWS
        ========================================== */

        function stopGameFlows() {

            if (codeSpawnTimer) {

                clearInterval(
            codeSpawnTimer
        );

                codeSpawnTimer = null;

            }


            if (bugSpawnTimer) {

                clearInterval(
            bugSpawnTimer
        );

                bugSpawnTimer = null;

            }

        }
        


        
        /* ==========================================
        COLLISION
        ========================================== */

        function checkCollision(
            object
        ) {

            var objectLane =
                parseInt(
                    object.dataset.lane,
                    10
                );


            if (
                objectLane !==
                playerLane
            ) {

                return false;

            }


            var objectTop =
                parseInt(
                    object.style.top,
                    10
                );


            var road =
                document.getElementById(
                    "road"
                );


            /*
            * Player is near bottom.
            */

            var playerPosition =
                road.clientHeight - 95;


            return (
                objectTop >=
                    playerPosition - 35
                &&
                objectTop <=
                    playerPosition + 35
            );

        }


        /* ==========================================
        HIT BUG
        ========================================== */

        function hitBug(
            object
        ) {

            score -= 5;


            if (score < 0) {

                score = 0;

            }


            loseLife();


            removeObject(
                object
            );

        }


        /* ==========================================
        REMOVE OBJECT
        ========================================== */

        function removeObject(
            object
        ) {

            if (!object) {

                return;

            }


            if (object.parentNode) {

                object.parentNode.removeChild(
                    object
                );

            }


            var index =
                activeObjects.indexOf(
                    object
                );


            if (index >= 0) {

                activeObjects.splice(
                    index,
                    1
                );

            }

        }


        /* ==========================================
        LOSE LIFE
        ========================================== */

        function loseLife() {

            if (
                !gameRunning ||
                gameFinished
            ) {

                return;

            }


            lives--;


            updateStats();


            if (lives <= 0) {

                lives = 0;

                updateStats();

                finishGame();

            }

        }


        /* ==========================================
        UPDATE HUD
        ========================================== */

        function updateStats() {

            document.getElementById(
        "scoreText"
    ).innerText =
        score;


            document.getElementById(
        "livesText"
    ).innerText =
        getHearts();


            document.getElementById(
        "codeText"
    ).innerText =
        collectedTokens.length
        +
        " / "
        +
        tokens.length;


            /*
            * Send JavaScript values
            * to ASP.NET HiddenFields
            */

            document.getElementById(
        '<%= hiddenScore.ClientID %>'
    ).value =
        score;


            document.getElementById(
        '<%= hiddenLives.ClientID %>'
    ).value =
        lives;

        }

        function getHearts() {

            var hearts = "";

            for (
        var i = 0;
        i < lives;
        i++
    ) {

                hearts += "♥ ";

            }

            return hearts;

        }
        /* ==========================================
        FINISH GAME
        ========================================== */

        function finishGame() {

            if (gameFinished) {

                return;

            }


            gameFinished = true;

            gameRunning = false;

            stopGameFlows();

            if (gameTimer) {

                clearInterval(
                    gameTimer
                );

                gameTimer = null;

            }


            /*
            * Stop all falling objects
            */

            var road =
                document.getElementById(
                    "road"
                );


            var objects =
                road.querySelectorAll(
                    ".code-token, .bug-token"
                );


            for (
                var i = 0;
                i < objects.length;
                i++
            ) {

                objects[i].remove();

            }


            /*
            * Save collected tokens
            */

            document.getElementById(
                '<%= hiddenCollectedTokens.ClientID %>'
            ).value = JSON.stringify(collectedTokens);


            document.getElementById( '<%= hiddenScore.ClientID %>').value = score;

            document.getElementById(    '<%= hiddenLives.ClientID %>').value =    lives;

            if (lives <= 0) {

                showGameMessage(
                    "RUN OVER!",
                    "Opening Challenge..."
                );

            }

            else {

                showGameMessage(
                    "CODE COLLECTION COMPLETE!",
                    "Opening Challenge..."
                );

            }


            /*
            * Send result to ASP.NET
            */

            setTimeout(
                function () {

                    postGameResult();

                },
                1000
            );

        }


        /* ==========================================
        SEND TO SERVER
        ========================================== */

        function postGameResult() {

            var hidden =
                document.getElementById(
                    '<%= hiddenCollectedTokens.ClientID %>'
                );


            hidden.value =
                JSON.stringify(
                    collectedTokens
                );


            document.getElementById(
                '<%= btnGameEnded.ClientID %>'
            ).click();

        }


        /* ==========================================
        MESSAGE
        ========================================== */

        function showGameMessage(
            title,
            text
        ) {

            document.getElementById(
                "messageTitle"
            ).innerText =
                title;


            document.getElementById(
                "messageText"
            ).innerText =
                text;


            document.getElementById(
                "gameMessage"
            ).style.display =
                "flex";

        }


        /* ==========================================
        START BUTTON
        ========================================== */

        document.getElementById(
            "startButton"
        ).onclick =
            function () {

                startGame();

            };


        /* ==========================================
        PAGE LOAD
        ========================================== */

        window.onload =
            function () {

                loadGameData();

                positionPlayer();

                updateStats();

            };


        /* ==========================================
        WINDOW RESIZE
        ========================================== */

        window.onresize =
            function () {

                positionPlayer();

            };

    </script>

</form>

</body>

</html>