<%@ Page Language="VB"
    AutoEventWireup="false"
    CodeFile="Challenge.aspx.vb"
    Inherits="ChallengePage.Challenge" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Code Runner - Challenge</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(180deg, #184c63, #2f9ea6);
            min-height: 100vh;
        }

        .top-nav {
            height: 65px;
            background: #163f54;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 25px;
            color: white;
        }

        .brand {
            font-size: 30px;
            font-weight: 900;
        }

        .brand-yellow {
            color: #facc15;
        }

        .brand-green {
            color: #4ade80;
        }

        .nav-right { display: flex; align-items: center; gap: 15px; }
        .user-badge {
            display: flex; align-items: center; gap: 8px;
            background: rgba(255, 255, 255, 0.15); padding: 5px 14px; border-radius: 20px;
        }
        .user-avatar { font-size: 16px; color: #4ade80; }
        .user-name { font-size: 13px; font-weight: 700; color: #ffffff; }

        .container {
            width: 1200px;
            max-width: 95%;
            margin: 30px auto;
        }

        .title {
            text-align: center;
            color: white;
            font-size: 42px;
            font-weight: 900;
        }

        .subtitle {
            text-align: center;
            color: #e2e8f0;
            font-size: 19px;
            margin-bottom: 25px;
        }

        .level-box {
            text-align: center;
            color: #facc15;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .panel {
            background: white;
            border-radius: 18px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .panel-title {
            font-size: 24px;
            font-weight: 900;
            color: #17324d;
            margin-bottom: 15px;
        }

        /* ================================
           COLLECTED TOKENS
           ================================ */

        .tokens-box {
            min-height: 120px;
            padding: 18px;
            border: 2px dashed #94a3b8;
            border-radius: 12px;
            background: #f8fafc;
        }

        .token {
            display: inline-block;
            background: #17324d;
            color: white;
            padding: 8px 12px;
            margin: 5px;
            border-radius: 7px;
            font-family: Consolas, monospace;
            font-weight: bold;
        }

        /* ================================
           PROBLEM
           ================================ */

        .problem {
            background: #eff6ff;
            border-left: 5px solid #2563eb;
            padding: 18px;
            border-radius: 8px;
            font-size: 17px;
            line-height: 1.6;
            color: #1e293b;
        }

        /* ================================
           CODE EDITOR
           ================================ */

        .code-area {
            width: 100%;
            min-height: 330px;
            resize: vertical;
            background: #111827;
            color: #f8fafc;
            border: none;
            border-radius: 12px;
            padding: 20px;
            font-family: Consolas, 'Courier New', monospace;
            font-size: 16px;
            line-height: 1.5;
            outline: none;
        }

        .code-area:focus {
            box-shadow: 0 0 0 3px #4ade80;
        }

        .button-row {
            margin-top: 15px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn {
            border: none;
            border-radius: 10px;
            padding: 13px 25px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-run {
            background: #16a34a;
            color: white;
        }

        .btn-run:hover {
            background: #15803d;
        }

        .btn-clear {
            background: #64748b;
            color: white;
        }

        .btn-clear:hover {
            background: #475569;
        }

        /* ================================
           OUTPUT
           ================================ */

        .output-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .output-box {
            min-height: 150px;
            background: #0f172a;
            color: #4ade80;
            border-radius: 12px;
            padding: 20px;
            font-family: Consolas, monospace;
            white-space: pre-wrap;
            overflow-x: auto;
        }

        .expected-box {
            color: #facc15;
        }

        /* ================================
           RESULT
           ================================ */

        .result-box {
            text-align: center;
            padding: 25px;
            border-radius: 12px;
            background: #f8fafc;
            font-size: 22px;
            font-weight: bold;
        }

        .success {
            color: #15803d;
        }

        .failure {
            color: #dc2626;
        }

        .score {
            margin-top: 10px;
            font-size: 18px;
            color: #334155;
        }

        .next-button {
            margin-top: 20px;
            background: #f97316;
            color: white;
            display: none;
        }

        .next-button:hover {
            background: #ea580c;
        }

        .loading {
            display: none;
            color: #2563eb;
            font-weight: bold;
            margin-top: 10px;
        }

        @media(max-width: 800px) {

            .output-grid {
                grid-template-columns: 1fr;
            }

            .title {
                font-size: 32px;
            }

        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="top-nav">

        <div class="brand">
            <span class="brand-yellow">Code</span>
            <span class="brand-green">Runner</span>
        </div>

         <div class="nav-right">
                <div class="user-badge">
                    <span class="user-avatar">🎮</span>
                    <asp:Label id="lblUsername" runat="server" CssClass="user-name" Text="Player"></asp:Label>
                </div>
        </div>

    </div>


    <div class="container">

        <div class="title">
            LEVEL CHALLENGE
        </div>

        <div class="level-box">
            <asp:Label
                ID="lblLevel"
                runat="server">
            </asp:Label>
        </div>

        <div class="subtitle">
            Type the collected code in the correct order and run the program.
        </div>


        <!-- =========================================
             COLLECTED CODES
             ========================================= -->

        <div class="panel">

            <div class="panel-title">
                COLLECTED CODES
            </div>

            <div class="tokens-box">

                <asp:Literal
                    ID="litCollectedCodes"
                    runat="server">
                </asp:Literal>

            </div>

        </div>


        <!-- =========================================
             PROBLEM
             ========================================= -->

        <div class="panel">

            <div class="panel-title">
                PROBLEM
            </div>

            <div class="problem">

                <asp:Literal
                    ID="litProblem"
                    runat="server">
                </asp:Literal>

            </div>

        </div>


        <!-- =========================================
             CODE EDITOR
             ========================================= -->

        <div class="panel">

            <div class="panel-title">
                TYPE YOUR SOLUTION
            </div>

            <textarea
                id="txtCode"
                class="code-area"
                placeholder="Type your Python program here..."></textarea>

            <div class="button-row">

                <button
                    type="button"
                    class="btn btn-run"
                    onclick="runCode()">
                    ▶ RUN CODE
                </button>

                <button
                    type="button"
                    class="btn btn-clear"
                    onclick="clearCode()">
                    CLEAR
                </button>

            </div>

            <div
                id="loading"
                class="loading">
                Running your Python program...
            </div>

        </div>


        <!-- =========================================
             OUTPUT
             ========================================= -->

        <div class="panel">

            <div class="panel-title">
                OUTPUT COMPARISON
            </div>

            <div class="output-grid">

                <div>

                    <h3>
                        ACTUAL OUTPUT
                    </h3>

                    <div
                        id="actualOutput"
                        class="output-box">
                        Program output will appear here.
                    </div>

                </div>


                <div>

                    <h3>
                        EXPECTED OUTPUT
                    </h3>

                    <div
                        id="expectedOutput"
                        class="output-box expected-box">
                        <asp:Literal
                            ID="litExpectedOutput"
                            runat="server">
                        </asp:Literal>
                    </div>

                </div>

            </div>

        </div>


        <!-- =========================================
             RESULT
             ========================================= -->

        <div class="panel">

            <div class="panel-title">
                RESULT
            </div>

            <div
                id="resultBox"
                class="result-box">

                Run your program to see the result.

                <div
                    id="scoreText"
                    class="score">
                </div>

                <button
                    type="button"
                    id="nextButton"
                    class="btn next-button"
                    onclick="goNextLevel()">
                    NEXT LEVEL →
                </button>

            </div>

        </div>


        <!-- Hidden values -->

        <asp:HiddenField
            ID="hiddenLevel"
            runat="server" />

        <asp:HiddenField
            ID="hiddenUsername"
            runat="server" />

        <asp:HiddenField
            ID="hiddenUserId"
            runat="server" />

    </div>

</form>


<script type="text/javascript">

    var passed = false;


    function runCode() {

        var code =
            document.getElementById("txtCode").value;

        var level =
            document.getElementById("<%= hiddenLevel.ClientID %>").value;

        var username =
            document.getElementById("<%= hiddenUsername.ClientID %>").value;

        var userId =
            document.getElementById("<%= hiddenUserId.ClientID %>").value;


        if (code.trim() === "") {

            alert("Please type your Python code.");

            return;

        }


        document.getElementById("loading").style.display = "block";

        document.getElementById("actualOutput").innerText =
            "Running...";

        document.getElementById("resultBox").className =
            "result-box";

        document.getElementById("resultBox").childNodes[0].nodeValue =
            "Running...";


        fetch("http://localhost:3000/api/game/run-challenge", {

            method: "POST",

            headers: {
                "Content-Type": "application/json"
            },

            body: JSON.stringify({

                username: username,

                userId: userId,

                level: parseInt(level),

                code: code

            })

        })

        .then(function(response) {

            return response.json();

        })

        .then(function(data) {

            document.getElementById("loading").style.display =
                "none";


            if (!data.success) {

                document.getElementById("actualOutput").innerText =
                    data.error || "Execution failed.";

                document.getElementById("resultBox").className =
                    "result-box failure";

                document.getElementById("resultBox").childNodes[0].nodeValue =
                    "❌ PROGRAM ERROR";

                return;

            }


            document.getElementById("actualOutput").innerText =
                data.actualOutput;


            document.getElementById("expectedOutput").innerText =
                data.expectedOutput;


            if (data.passed) {

                passed = true;

                document.getElementById("resultBox").className =
                    "result-box success";

                document.getElementById("resultBox").childNodes[0].nodeValue =
                    "✅ CORRECT!";

                document.getElementById("scoreText").innerText =
                    "Score Earned: " + data.scoreEarned;


                document.getElementById("nextButton").style.display =
                    "inline-block";

            }

            else {

                passed = false;

                document.getElementById("resultBox").className =
                    "result-box failure";

                document.getElementById("resultBox").childNodes[0].nodeValue =
                    "❌ WRONG OUTPUT";

                document.getElementById("scoreText").innerText =
                    "Try again.";

                document.getElementById("nextButton").style.display =
                    "none";

            }

        })

        .catch(function(error) {

            document.getElementById("loading").style.display =
                "none";

            document.getElementById("actualOutput").innerText =
                error.toString();

            document.getElementById("resultBox").className =
                "result-box failure";

            document.getElementById("resultBox").childNodes[0].nodeValue =
                "❌ SERVER ERROR";

        });

    }


    function clearCode() {

        document.getElementById("txtCode").value = "";

        document.getElementById("actualOutput").innerText =
            "Program output will appear here.";

        document.getElementById("resultBox").className =
            "result-box";

        document.getElementById("scoreText").innerText = "";

        document.getElementById("nextButton").style.display =
            "none";

    }


    function goNextLevel() {

        var level =
            parseInt(
                document.getElementById(
                    "<%= hiddenLevel.ClientID %>"
                ).value
            );


        if (!passed) {

            alert("Solve the challenge correctly first.");

            return;

        }


        if (level >= 10) {

            alert("Congratulations! You completed all 10 levels.");

            window.location.href =
                "../Home/Home.aspx";

            return;

        }


        var nextLevel = level + 1;


        window.location.href =
            "../LevelPage/Levels.aspx";

    }

</script>


</body>

</html>