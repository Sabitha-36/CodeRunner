<%@ Page Language="VB"    AutoEventWireup="false"    CodeFile="Dashboard.aspx.vb"    Inherits="Admin.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Code Runner - Admin Dashboard</title>

    <style type="text/css">

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html,
        body {

            width: 100%;
            min-height: 100vh;

            font-family:
                'Segoe UI',
                Tahoma,
                Geneva,
                Verdana,
                sans-serif;

            background:
                linear-gradient(
                    180deg,
                    #184c63 0%,
                    #2f9ea6 45%,
                    #58cdc9 100%
                );

            color: #0f172a;
        }

        /* =========================================
           TOP NAVIGATION
        ========================================= */

        .top-nav {

            width: 100%;
            height: 58px;

            background: #1a4258;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 25px;

            box-shadow:
                0 3px 12px rgba(0,0,0,0.25);

            position: sticky;
            top: 0;

            z-index: 100;
        }

        .brand {

            font-size: 25px;
            font-weight: 900;
        }

        .brand-yellow {
            color: #facc15;
        }

        .brand-green {
            color: #4ade80;
        }

        .admin-title {

            color: white;

            font-size: 13px;
            font-weight: 800;

            letter-spacing: 1px;

            background:
                rgba(255,255,255,0.10);

            padding:
                8px 15px;

            border-radius: 20px;
        }

        /* =========================================
           MAIN PAGE
        ========================================= */

        .page-wrapper {

            width: 94%;
            max-width: 1250px;

            margin: 25px auto 50px auto;
        }

        .page-heading {

            display: flex;

            justify-content: space-between;
            align-items: center;

            margin-bottom: 20px;
        }

        .page-heading h1 {

            color: white;

            font-size: 27px;

            font-weight: 900;
        }

        .page-heading p {

            color: #dbeafe;

            font-size: 12px;

            margin-top: 5px;
        }

        /* =========================================
           BUTTONS
        ========================================= */

        .btn {

            border: none;

            border-radius: 9px;

            padding:
                10px 17px;

            font-size: 12px;

            font-weight: 800;

            cursor: pointer;

            text-decoration: none;

            display: inline-block;

            transition:
                transform 0.15s ease,
                box-shadow 0.15s ease;
        }

        .btn:hover {

            transform: translateY(-2px);

            box-shadow:
                0 5px 14px rgba(0,0,0,0.20);
        }

        .btn-orange {

            background:
                linear-gradient(
                    180deg,
                    #ff9800,
                    #f57c00
                );

            color: white;
        }

        .btn-blue {

            background:
                linear-gradient(
                    180deg,
                    #38bdf8,
                    #0284c7
                );

            color: white;
        }

        .btn-green {

            background:
                linear-gradient(
                    180deg,
                    #4ade80,
                    #16a34a
                );

            color: white;
        }

        .btn-gray {

            background: #64748b;

            color: white;
        }

        /* =========================================
           DASHBOARD CARDS
        ========================================= */

        .dashboard-cards {

            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 15px;

            margin-bottom: 20px;
        }

        .stat-card {

            background: white;

            border-radius: 15px;

            padding: 18px;

            box-shadow:
                0 8px 22px rgba(0,0,0,0.18);

            position: relative;

            overflow: hidden;
        }

        .stat-card:after {

            content: "";

            position: absolute;

            left: 0;
            bottom: 0;

            width: 100%;
            height: 4px;

            background:
                linear-gradient(
                    90deg,
                    #facc15,
                    #4ade80
                );
        }

        .stat-icon {

            font-size: 24px;

            margin-bottom: 7px;
        }

        .stat-label {

            color: #64748b;

            font-size: 11px;

            font-weight: 800;

            text-transform: uppercase;
        }

        .stat-value {

            color: #1e293b;

            font-size: 25px;

            font-weight: 900;

            margin-top: 4px;
        }

        /* =========================================
           MAIN PANEL
        ========================================= */

        .panel {

            background: white;

            border-radius: 17px;

            padding: 22px;

            box-shadow:
                0 10px 28px rgba(0,0,0,0.20);

            margin-bottom: 20px;
        }

        .panel-header {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 18px;
        }

        .panel-title {

            color: #1e293b;

            font-size: 19px;

            font-weight: 900;
        }

        .panel-subtitle {

            color: #64748b;

            font-size: 11px;

            margin-top: 3px;
        }

        /* =========================================
           SEARCH
        ========================================= */

        .search-area {

            display: flex;

            gap: 9px;

            margin-bottom: 18px;
        }

        .search-box {

            flex: 1;

            padding: 11px 14px;

            border-radius: 9px;

            border:
                1px solid #cbd5e1;

            background: #f8fafc;

            color: #0f172a;

            font-size: 13px;

            outline: none;
        }

        .search-box:focus {

            border-color: #2f9ea6;

            background: white;
        }

        /* =========================================
           GRIDVIEW
        ========================================= */

        .players-table {

            width: 100%;

            border-collapse: collapse;

            font-size: 12px;
        }

        .players-table th {

            background: #1a4258;

            color: white;

            padding: 12px 9px;

            text-align: left;

            font-size: 10px;

            text-transform: uppercase;

            letter-spacing: .4px;
        }

        .players-table td {

            padding: 11px 9px;

            border-bottom:
                1px solid #e2e8f0;

            color: #334155;

            font-weight: 600;
        }

        .players-table tr:hover td {

            background: #f0fdfa;
        }

        .players-table tr:last-child td {

            border-bottom: none;
        }

        /* =========================================
           STATUS
        ========================================= */

        .status-online {

            display: inline-block;

            padding: 4px 9px;

            border-radius: 15px;

            background: #dcfce7;

            color: #15803d;

            font-size: 10px;

            font-weight: 900;
        }

        .status-offline {

            display: inline-block;

            padding: 4px 9px;

            border-radius: 15px;

            background: #f1f5f9;

            color: #64748b;

            font-size: 10px;

            font-weight: 900;
        }

        /* =========================================
           PLAYER BADGE
        ========================================= */

        .player-name {

            color: #0f766e;

            font-weight: 900;
        }

        .level-badge {

            background: #dbeafe;

            color: #1d4ed8;

            padding: 4px 8px;

            border-radius: 7px;

            font-size: 10px;

            font-weight: 900;
        }

        /* =========================================
           MESSAGE
        ========================================= */

        .message {

            display: block;

            padding: 10px 14px;

            border-radius: 9px;

            margin-bottom: 15px;

            background: #fee2e2;

            color: #b91c1c;

            font-size: 12px;

            font-weight: 700;
        }

        /* =========================================
           QUICK ACTIONS
        ========================================= */

        .quick-actions {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 12px;
        }

        .action-box {

            padding: 16px;

            border-radius: 12px;

            background: #f8fafc;

            border:
                1px solid #e2e8f0;

            text-align: center;
        }

        .action-box h3 {

            font-size: 14px;

            color: #1e293b;

            margin-bottom: 5px;
        }

        .action-box p {

            font-size: 10px;

            color: #64748b;

            margin-bottom: 12px;
        }

        /* =========================================
           FOOTER
        ========================================= */

        .footer {

            text-align: center;

            color: #dbeafe;

            font-size: 10px;

            margin-top: 25px;
        }

        /* =========================================
           RESPONSIVE
        ========================================= */

        @media screen and (max-width: 900px) {

            .dashboard-cards {

                grid-template-columns:
                    repeat(2, 1fr);
            }

            .quick-actions {

                grid-template-columns:
                    1fr;
            }
        }

        @media screen and (max-width: 600px) {

            .dashboard-cards {

                grid-template-columns: 1fr;
            }

            .page-heading {

                flex-direction: column;

                align-items: flex-start;

                gap: 12px;
            }

            .search-area {

                flex-direction: column;
            }

            .panel {

                overflow-x: auto;
            }
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <!-- =========================================
         TOP NAVIGATION
    ========================================== -->

    <div class="top-nav">

        <div class="brand">

            <span class="brand-yellow">Code</span>
            <span class="brand-green">Runner</span>

        </div>

        <div class="admin-title">

            ADMIN DASHBOARD

        </div>

    </div>


    <!-- =========================================
         MAIN CONTENT
    ========================================== -->

    <div class="page-wrapper">

        <!-- PAGE HEADING -->

        <div class="page-heading">

            <div>

                <h1>Admin Control Center</h1>

                <p>
                    Manage Code Runner players and monitor game activity
                </p>

            </div>

            <asp:Button
                ID="btnRefresh"
                runat="server"
                Text="↻ REFRESH PLAYERS"
                CssClass="btn btn-orange"
                OnClick="btnRefresh_Click" />

        </div>


        <!-- MESSAGE -->

        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="message"
            Visible="false">
        </asp:Label>


        <!-- =========================================
             STATISTICS
        ========================================== -->

        <div class="dashboard-cards">

            <div class="stat-card">

                <div class="stat-icon">👥</div>

                <div class="stat-label">
                    Total Players
                </div>

                <div class="stat-value">

                    <asp:Label
                        ID="lblPlayerCount"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


            <div class="stat-card">

                <div class="stat-icon">🟢</div>

                <div class="stat-label">
                    Logged Players
                </div>

                <div class="stat-value">

                    <asp:Label
                        ID="lblOnlineCount"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


            <div class="stat-card">

                <div class="stat-icon">🎮</div>

                <div class="stat-label">
                    Games Played
                </div>

                <div class="stat-value">

                    <asp:Label
                        ID="lblGamesPlayed"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


            <div class="stat-card">

                <div class="stat-icon">🏆</div>

                <div class="stat-label">
                    Highest Score
                </div>

                <div class="stat-value">

                    <asp:Label
                        ID="lblHighestScore"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </div>

            </div>

        </div>


        <!-- =========================================
             PLAYER MANAGEMENT
        ========================================== -->

        <div class="panel">

            <div class="panel-header">

                <div>

                    <div class="panel-title">
                        Player Management
                    </div>

                    <div class="panel-subtitle">
                        Real players registered and logged into Code Runner
                    </div>

                </div>

            </div>


            <!-- SEARCH -->

            <div class="search-area">

                <asp:TextBox
                    ID="txtSearch"
                    runat="server"
                    CssClass="search-box"
                    placeholder="Search by username, email or player ID...">
                </asp:TextBox>

                <asp:Button
                    ID="btnSearch"
                    runat="server"
                    Text="SEARCH"
                    CssClass="btn btn-blue"
                    OnClick="btnSearch_Click" />

                <asp:Button
                    ID="btnClearSearch"
                    runat="server"
                    Text="CLEAR"
                    CssClass="btn btn-gray"
                    OnClick="btnClearSearch_Click" />

            </div>


            <!-- PLAYER TABLE -->

            <asp:GridView
                ID="gvPlayers"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="players-table"
                GridLines="None"
                EmptyDataText="No registered players found.">

                <Columns>

                    <asp:BoundField
                        DataField="username"
                        HeaderText="PLAYER"
                        ItemStyle-CssClass="player-name" />

                    <asp:BoundField
                        DataField="email"
                        HeaderText="EMAIL" />

                    <asp:BoundField
                        DataField="character"
                        HeaderText="CHARACTER" />

                    <asp:BoundField
                        DataField="level"
                        HeaderText="LEVEL" />

                    <asp:BoundField
                        DataField="score"
                        HeaderText="SCORE" />

                    <asp:BoundField
                        DataField="gamesPlayed"
                        HeaderText="GAMES" />

                    <asp:BoundField
                        DataField="lastLogin"
                        HeaderText="LAST LOGIN" />

                    <asp:BoundField
                        DataField="status"
                        HeaderText="STATUS" />

                </Columns>

            </asp:GridView>

        </div>


        <!-- =========================================
             QUICK ACTIONS
        ========================================== -->

        <div class="panel">

            <div class="panel-title">
                Quick Actions
            </div>

            <div class="panel-subtitle"
                 style="margin-bottom:16px;">
                Administrator controls
            </div>


            <div class="quick-actions">

                <div class="action-box">

                    <h3>🎮 Game Settings</h3>

                    <p>
                        View the current Code Runner game configuration.
                    </p>

                    <asp:Button
                        ID="btnGameSettings"
                        runat="server"
                        Text="VIEW SETTINGS"
                        CssClass="btn btn-blue"
                        OnClick="btnGameSettings_Click" />

                </div>


                <div class="action-box">

                    <h3>👥 Player Records</h3>

                    <p>
                        Refresh and view the latest registered players.
                    </p>

                    <asp:Button
                        ID="btnPlayerRecords"
                        runat="server"
                        Text="REFRESH RECORDS"
                        CssClass="btn btn-green"
                        OnClick="btnRefresh_Click" />

                </div>


                <div class="action-box">

                    <h3>🚪 Administrator</h3>

                    <p>
                        Return to the Code Runner home page.
                    </p>

                    <asp:Button
                        ID="btnLogout"
                        runat="server"
                        Text="EXIT ADMIN"
                        CssClass="btn btn-orange"
                        OnClick="btnLogout_Click" />

                </div>

            </div>

        </div>


        <!-- FOOTER -->

        <div class="footer">

            Code Runner • Administrator Control Center

        </div>

    </div>

</form>

</body>

</html>