<%@ Page Language="VB" AutoEventWireup="false"    CodeFile="Levels.aspx.vb"    Inherits="LevelPage.Levels" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <title>Code Runner - Levels</title>

    <style type="text/css">

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html, body {
            width: 100%;
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(
                180deg,
                #184c63 0%,
                #2f9ea6 50%,
                #58cdc9 100%
            );
        }

        .top-nav {
            width: 100%;
            height: 55px;
            background-color: #1a4258;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.25);
        }

        .nav-brand {
            font-size: 24px;
            font-weight: 800;
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


        .level-container {
            width: 900px;
            max-width: 95%;
            margin: 35px auto;
        }

        .title {
            text-align: center;
            color: white;
            font-size: 32px;
            font-weight: 900;
            margin-bottom: 8px;
        }

        .subtitle {
            text-align: center;
            color: #e2e8f0;
            margin-bottom: 30px;
        }

        .levels {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .level-card {
            background: white;
            border-radius: 18px;
            padding: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .level-number {
            font-size: 22px;
            font-weight: 900;
            color: #1e293b;
        }

        .program-name {
            margin-top: 6px;
            color: #475569;
            font-size: 14px;
        }

        .btn-level {
            width: 100%;
            margin-top: 15px;
            padding: 11px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(
                180deg,
                #ff9800,
                #f57c00
            );
            color: white;
            font-size: 14px;
            font-weight: 800;
            cursor: pointer;
        }

        .btn-level:hover {
            background: #e65100;
        }

        .locked {
            background: #94a3b8;
            cursor: not-allowed;
        }

        @media(max-width:700px) {

            .levels {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="top-nav">

        <div class="nav-brand">
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


    <div class="level-container">

        <div class="title">
            SELECT LEVEL
        </div>

        <div class="subtitle">
            Complete each Python challenge to unlock the next level.
        </div>


        <div class="levels">

            <!-- LEVEL 1 -->

            <div class="level-card">

                <div class="level-number">
                    LEVEL 1
                </div>

                <div class="program-name">
                    Sum of Three Numbers
                </div>

                <asp:Button
                    ID="btnLevel1"
                    runat="server"
                    Text="START LEVEL"
                    CssClass="btn-level"
                    OnClick="Level1_Click" />

            </div>


            <!-- LEVEL 2 -->

            <div class="level-card">

                <div class="level-number">
                    LEVEL 2
                </div>

                <div class="program-name">
                    Greatest of Three Numbers
                </div>

                <asp:Button
                    ID="btnLevel2"
                    runat="server"
                    Text="START LEVEL"
                    CssClass="btn-level" 
                    OnClick="Level2_Click"/>

            </div>


            <!-- LEVEL 3 -->

            <div class="level-card">

                <div class="level-number">
                    LEVEL 3
                </div>

                <div class="program-name">
                    Odd or Even
                </div>

                <asp:Button
                    ID="btnLevel3"
                    runat="server"
                    Text="START LEVEL"
                    CssClass="btn-level"
                    OnClick="Level3_Click" />

            </div>


            <!-- LEVEL 4 -->

            <div class="level-card">

                <div class="level-number">
                    LEVEL 4
                </div>

                <div class="program-name">
                    Positive or Negative
                </div>

                <asp:Button
                    ID="btnLevel4"
                    runat="server"
                    Text="START LEVEL"
                    CssClass="btn-level" 
                    OnClick="Level4_Click"/>

            </div>


            <!-- LEVEL 5 -->

            <div class="level-card">

                <div class="level-number">
                    LEVEL 5
                </div>

                <div class="program-name">
                    Palindrome Check
                </div>

                <asp:Button
                    ID="btnLevel5"
                    runat="server"
                    Text="START LEVEL"
                    CssClass="btn-level" 
                    OnClick="Level5_Click"/>

            </div>


            <!-- LEVEL 6 -->

            <div class="level-card">

                <div class="level-number">
                    LEVEL 6
                </div>

                <div class="program-name">
                    Square Root & Cube Root
                </div>

                <asp:Button
                    ID="btnLevel6"
                    runat="server"
                    Text="START LEVEL"
                    CssClass="btn-level" 
                    OnClick="Level6_Click"/>

            </div>


            <!-- LEVEL 7 -->

            <div class="level-card">

                <div class="level-number">
                    LEVEL 7
                </div>

                <div class="program-name">
                    Simple Interest
                </div>

                <asp:Button
                    ID="btnLevel7"
                    runat="server"
                    Text="START LEVEL"
                    CssClass="btn-level" 
                    OnClick="Level7_Click"/>

            </div>


            <!-- LEVEL 8 -->

            <div class="level-card">

                <div class="level-number">
                    LEVEL 8
                </div>

                <div class="program-name">
                    Student Percentage & Total
                </div>

                <asp:Button
                    ID="btnLevel8"
                    runat="server"
                    Text="START LEVEL"
                    CssClass="btn-level" 
                    OnClick="Level8_Click"/>

            </div>


            <!-- LEVEL 9 -->

            <div class="level-card">

                <div class="level-number">
                    LEVEL 9
                </div>

                <div class="program-name">
                    Calculator Using Functions
                </div>

                <asp:Button
                    ID="btnLevel9"
                    runat="server"
                    Text="START LEVEL"
                    CssClass="btn-level" 
                    OnClick="Level9_Click"/>

            </div>


            <!-- LEVEL 10 -->

            <div class="level-card">

                <div class="level-number">
                    LEVEL 10
                </div>

                <div class="program-name">
                    Employee Salary Using Class & Objects
                </div>

                <asp:Button
                    ID="btnLevel10"
                    runat="server"
                    Text="START LEVEL"
                    CssClass="btn-level" 
                    OnClick="Level10_Click"/>

            </div>

        </div>

    </div>

</form>

</body>
</html>