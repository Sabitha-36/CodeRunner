const path = require('path');
const fs = require('fs');
const os = require('os');
const { execFile } = require('child_process');
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { MongoClient } = require('mongodb');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// MongoDB
const mongoUrl = 'mongodb://127.0.0.1:27017';
const dbName = 'CodeRunner';
let db;
let mongoClient;

async function connectMongoDB() {

    try {

        mongoClient = new MongoClient(mongoUrl);

        await mongoClient.connect();

        db = mongoClient.db(dbName);

        app.locals.db = db;

        console.log('=================================');
        console.log('Successfully connected to MongoDB');
        console.log('Database:', dbName);
        console.log('=================================');

    }
    catch (error) {

        console.error(
            'MongoDB Connection Error:',
            error
        );

        process.exit(1);
    }
}

// ==============================
// LOGIN API
// ==============================

app.post('/api/login', async (req, res) => {

    try {

        const { username, password } = req.body;

        console.log("--> Login Attempt:", { username });


        // Validation
        if (!username || !password) {

            console.log("--> Failed: Missing username or password");

            return res.status(400).json({
                success: false,
                message: 'Username and password are required.'
            });
        }


        // Find user
        const user = await db.collection('users').findOne({
            $or: [
                { username: username },
                { email: username }
            ]
        });


        console.log("--> Database Result:",
            user ? user.username : "User not found"
        );


        // Check credentials
        if (!user || user.password !== password) {

            console.log("--> Failed: Invalid credentials");

            return res.status(401).json({
                success: false,
                message: 'Invalid username or password.'
            });
        }
        

        // Login successful
        console.log("--> Success! Logging in:", user.username);
        const { ObjectId } = require('mongodb');

await db.collection('users').updateOne(

    {
        _id: user._id
    },

    {
        $set: {

            status: "online",

            lastLogin: new Date()

        }

    }

);

        return res.status(200).json({

            success: true,

            message: 'Login successful!',

            user: {
                _id: user._id.toString(),
                username: user.username,
                character: user.character || 'Default'
            }

        });


    } catch (error) {

        console.error('Login Endpoint Error:', error);

        return res.status(500).json({
            success: false,
            message: 'Internal server error.'
        });

    }

});


// ==============================
// REGISTER API
// ==============================

app.post('/api/register', async (req, res) => {

    try {

        const { username, email, password } = req.body;

        console.log("--> Registration Attempt:", {
            username,
            email
        });


        if (!username || !email || !password) {

            return res.status(400).json({
                success: false,
                message: 'All fields are required.'
            });

        }


        // Check existing user
        const existingUser =
            await db.collection('users').findOne({

                $or: [
                    { username: username },
                    { email: email }
                ]

            });


        if (existingUser) {

            console.log(
                "--> Failed: User or Email already exists"
            );

            return res.status(400).json({
                success: false,
                message: 'Username or Email already exists.'
            });

        }


        // Create user
        const newUser = {

    username: username,

    email: email,

    password: password,

    character: 'RunnerOne',

    score: 0,

    xp: 0,

    currentLevel: 1,

    gamesPlayed: 0,

    challengesSolved: 0,

    status: "offline",

    lastLogin: null,

    createdAt: new Date()

};

        const result =
            await db.collection('users').insertOne(newUser);


        console.log(
            "--> Success: User registered with ID:",
            result.insertedId
        );


        return res.status(200).json({

            success: true,

            message: 'User registered successfully!',

            userId: result.insertedId.toString()

        });


    } catch (error) {

        console.error(
            'Register Endpoint Error:',
            error
        );

        return res.status(500).json({

            success: false,

            message: 'Internal server error.'

        });

    }

});


// ==============================
// SAVE GAME RESULT
// ==============================

app.post('/api/game/save-codes', async (req, res) => {

    try {

        const {
            userId,
            username,
            level,
            score,
            lives,
            collectedCodes
        } = req.body;

        console.log("=================================");
        console.log("--> GAME RESULT RECEIVED");
        console.log("Username:", username);
        console.log("User ID:", userId);
        console.log("Level:", level);
        console.log("Score:", score);
        console.log("Lives:", lives);
        console.log("Collected Codes:", collectedCodes);
        console.log("=================================");


        // Validate username
        if (!username) {

            return res.status(400).json({
                success: false,
                message: "Username is required."
            });

        }


        // Make sure collectedCodes is an array
        if (!Array.isArray(collectedCodes)) {

            return res.status(400).json({
                success: false,
                message: "Collected codes must be an array."
            });

        }


        // Create game result
        const gameResult = {

            userId: userId || null,

            username: username,

            level: parseInt(level) || 1,

            score: parseInt(score) || 0,

            lives: parseInt(lives) || 0,

            collectedCodes: collectedCodes,

            completed: true,

            createdAt: new Date()

        };


        // Insert into Collectioncode
        const result =
            await db.collection('Collectioncode').insertOne(gameResult);

        await db.collection('users').updateOne(

    {
        username: username
    },

    {
        $inc: {
            gamesPlayed: 1
        }
    }

);
        console.log( "--> Game result saved successfully." );

        console.log("--> MongoDB ID:",result.insertedId  );


        return res.status(200).json({
            success: true,
            message: "Game result saved successfully.",
            id: result.insertedId.toString()

        });

    }
    catch (error) {

        console.error("--> Save Game Error:", error );

        return res.status(500).json({
            success: false,
            message: "Failed to save game result."
        });

    }

});

// ============================================================
// CHALLENGE - LOAD USER + COLLECTED CODES
// ============================================================

app.get('/api/challenge/data', async (req, res) => {

    try {

        const username = String(req.query.username || '').trim();
        const level = parseInt(req.query.level);

        console.log("=================================");
        console.log("--> CHALLENGE DATA REQUEST");
        console.log("Username:", username);
        console.log("Level:", level);
        console.log("=================================");

        // --------------------------------------------
        // VALIDATION
        // --------------------------------------------

        if (!username) {

            return res.status(400).json({
                success: false,
                message: "Username is required."
            });

        }

        if (!level) {

            return res.status(400).json({
                success: false,
                message: "Level is required."
            });

        }


        // --------------------------------------------
        // GET USER FROM users COLLECTION
        // --------------------------------------------

        const user = await db.collection('users').findOne({
            $or: [
                { username: username },
                { email: username }
            ]
        });


        if (!user) {

            console.log("--> User not found");

            return res.status(404).json({
                success: false,
                message: "User not found."
            });

        }


        // --------------------------------------------
        // GET GAME DATA FROM Collectioncode
        // --------------------------------------------

        const gameData = await db.collection('Collectioncode')
            .findOne(
                {
                    username: user.username,
                    level: level
                },
                {
                    sort: {
                        createdAt: -1
                    }
                }
            );


        // --------------------------------------------
        // IF NO GAME DATA FOUND
        // --------------------------------------------

        if (!gameData) {

            console.log("--> No collected code found");

            return res.status(404).json({
                success: false,
                message: "No collected codes found for this level."
            });

        }


        // --------------------------------------------
        // GET COLLECTED CODES
        // --------------------------------------------

        const collectedCodes =
            Array.isArray(gameData.collectedCodes)
                ? gameData.collectedCodes
                : [];


        // --------------------------------------------
        // SEND DATA TO ASP.NET
        // --------------------------------------------

        return res.status(200).json({

            success: true,

            user: {

                userId: user._id.toString(),

                username: user.username,

                character: user.character || "Default",

                score: user.score || 0,

                xp: user.xp || 0

            },

            level: level,

            collectedCodes: collectedCodes,

            gameScore: gameData.score || 0,

            lives: gameData.lives || 0,

            collectionId: gameData._id.toString()

        });

    }
    catch (error) {

        console.error(
            "--> Challenge Data API Error:",
            error
        );

        return res.status(500).json({

            success: false,

            message: "Failed to load challenge data."

        });

    }

});
// ============================================================
// CHALLENGE - EXPECTED OUTPUTS
// ============================================================

function getExpectedOutput(level) {

    switch (parseInt(level)) {

        case 1:
            return "60";

        case 2:
            return "25";

        case 3:
            return "Odd";

        case 4:
            return "Negative";

        case 5:
            return "Palindrome";

        case 6:
            return "8.0\n4.0";

        case 7:
            return "1000.0";

        case 8:
            return "245\n81.66666666666667";

        case 9:
            return "15\n5\n50\n2.0";

        case 10:
            return "1000.0";

        default:
            return "";

    }

}


// ============================================================
// NORMALIZE OUTPUT
// ============================================================

function normalizeOutput(output) {

    if (!output) {
        return "";
    }

    return output
        .replace(/\r\n/g, "\n")
        .replace(/\r/g, "\n")
        .trim()
        .split("\n")
        .map(line => line.trim())
        .join("\n");

}


// ============================================================
// RUN PYTHON CODE
// ============================================================

app.post('/api/game/run-challenge', async (req, res) => {

    let tempFile = null;

    try {

        const {
            username,
            userId,
            level,
            code
        } = req.body;


        // --------------------------------------------
        // VALIDATION
        // --------------------------------------------

        if (!username) {

            return res.status(400).json({

                success: false,

                error: "Username is required."

            });

        }


        if (!level) {

            return res.status(400).json({

                success: false,

                error: "Level is required."

            });

        }


        if (!code || !code.trim()) {

            return res.status(400).json({

                success: false,

                error: "Python code is required."

            });

        }


        if (code.length > 10000) {

            return res.status(400).json({

                success: false,

                error: "Code is too long."

            });

        }


        // --------------------------------------------
        // EXPECTED OUTPUT
        // --------------------------------------------

        const expectedOutput =
            getExpectedOutput(level);


        // --------------------------------------------
        // CREATE TEMP PYTHON FILE
        // --------------------------------------------

        const fileName =
            "coderunner_" +
            Date.now() +
            "_" +
            Math.floor(Math.random() * 100000) +
            ".py";


        tempFile =
            path.join(
                os.tmpdir(),
                fileName
            );


        fs.writeFileSync(
            tempFile,
            code,
            "utf8"
        );


        console.log(
            "Running Challenge - User:",
            username,
            "Level:",
            level
        );


        // --------------------------------------------
        // RUN PYTHON
        // --------------------------------------------

        execFile(
            "python",
            [tempFile],
            {
                timeout: 5000,
                maxBuffer: 1024 * 1024
            },

            async function(error, stdout, stderr) {


                // ------------------------------------
                // DELETE TEMP FILE
                // ------------------------------------

                try {

                    if (tempFile &&
                        fs.existsSync(tempFile)) {

                        fs.unlinkSync(tempFile);

                    }

                }
                catch (deleteError) {

                    console.log(
                        "Temp file delete error:",
                        deleteError.message
                    );

                }


                // ------------------------------------
                // PYTHON ERROR
                // ------------------------------------

                if (error) {

                    console.log(
                        "Python Execution Error:",
                        stderr || error.message
                    );


                    return res.json({

                        success: false,

                        error:
                            stderr ||
                            error.message ||
                            "Python execution failed."

                    });

                }


                // ------------------------------------
                // ACTUAL OUTPUT
                // ------------------------------------

                const actualOutput =
                    normalizeOutput(stdout);


                const expected =
                    normalizeOutput(
                        expectedOutput
                    );


                // ------------------------------------
                // COMPARE
                // ------------------------------------

                const passed =
                    actualOutput === expected;


                // ------------------------------------
                // SCORE
                // ------------------------------------

                let scoreEarned = 0;

                let xpEarned = 0;


                if (passed) {

                    scoreEarned = 100;

                    xpEarned = 25;

                }


                // ------------------------------------
                // SAVE CHALLENGE RESULT
                // ------------------------------------

                try {

                    const challengeData = {

                        username: username,

                        userId: userId || null,

                        level: parseInt(level),

                        submittedCode: code,

                        actualOutput: actualOutput,

                        expectedOutput: expected,

                        passed: passed,

                        scoreEarned: scoreEarned,

                        xpEarned: xpEarned,

                        submittedAt: new Date()

                    };


                    await db
                        .collection('Collectioncode')
                        .insertOne(challengeData);


                    console.log(
                        "Challenge saved to Collectioncode"
                    );

                }
                catch (saveError) {

                    console.error(
                        "Collectioncode Save Error:",
                        saveError
                    );

                }


                // ------------------------------------
                // UPDATE USER SCORE
                // ------------------------------------

                if (passed) {

                    try {

                        const { ObjectId } =
                            require('mongodb');


                        let userFilter;


                        // If UserId exists and is valid
                        if (
                            userId &&
                            ObjectId.isValid(userId)
                        ) {

                            userFilter = {

                                _id:
                                    new ObjectId(userId)

                            };

                        }

                        else {

                            userFilter = {

                                username:
                                    username

                            };

                        }


                        const nextLevel =
                            Math.min(
                                parseInt(level) + 1,
                                10
                            );


                        const updateResult =
                            await db
                                .collection('users')
                                .updateOne(

                                    userFilter,

                                    {

                                        $inc: {

                                            score:
                                                scoreEarned,

                                            xp:
                                                xpEarned,

                                            challengesSolved:
                                                1

                                        },

                                        $max: {

                                            currentLevel:
                                                nextLevel

                                        }

                                    }

                                );


                        console.log(
                            "User score update:",
                            updateResult.modifiedCount
                        );


                    }
                    catch (scoreError) {

                        console.error(
                            "User Score Update Error:",
                            scoreError
                        );

                    }

                }


                // ------------------------------------
                // SEND RESULT TO ASP.NET
                // ------------------------------------

                return res.json({

                    success: true,

                    passed: passed,

                    actualOutput: actualOutput,

                    expectedOutput: expected,

                    scoreEarned: scoreEarned,

                    xpEarned: xpEarned

                });

            }
        );

    }
    catch (error) {

        // ----------------------------------------
        // DELETE TEMP FILE IF ERROR OCCURS
        // ----------------------------------------

        try {

            if (
                tempFile &&
                fs.existsSync(tempFile)
            ) {

                fs.unlinkSync(tempFile);

            }

        }
        catch (e) {
        }


        console.error(
            "Challenge API Error:",
            error
        );


        return res.status(500).json({

            success: false,

            error:
                "Internal server error."

        });

    }

});
// ============================================================
// LEADERBOARD API
// ============================================================

app.get('/api/leaderboard', async (req, res) => {

    try {

        // Get all users
        const users = await db.collection('users')
            .find(
                {},
                {
                    projection: {
                        username: 1,
                        score: 1
                    }
                }
            )
            .sort({ score: -1 })
            .toArray();

        // Add rank
        const leaderboard = users.map((user, index) => {

            return {
                rank: index + 1,
                username: user.username,
                score: user.score || 0
            };

        });

        console.log("Leaderboard loaded successfully.");

        return res.status(200).json({
            success: true,
            leaderboard: leaderboard
        });

    }
    catch (error) {

        console.error(
            "Leaderboard API Error:",
            error
        );

        return res.status(500).json({
            success: false,
            message: "Failed to load leaderboard."
        });

    }

});
// ============================================================
// ADMIN - GET DASHBOARD STATISTICS
// ============================================================

app.get('/api/admin/stats', async (req, res) => {

    try {

        const usersCollection = db.collection('users');
        const gamesCollection = db.collection('Collectioncode');

        // --------------------------------------------
        // TOTAL PLAYERS
        // --------------------------------------------

        const totalPlayers =
            await usersCollection.countDocuments({});


        // --------------------------------------------
        // GAMES PLAYED
        // --------------------------------------------

        const gamesPlayed =
            await gamesCollection.countDocuments({
                completed: true
            });


        // --------------------------------------------
        // HIGHEST SCORE
        // --------------------------------------------

        const highestScoreResult =
            await usersCollection
                .find({})
                .sort({ score: -1 })
                .limit(1)
                .toArray();


        let highestScore = 0;

        if (
            highestScoreResult.length > 0 &&
            highestScoreResult[0].score
        ) {

            highestScore =
                highestScoreResult[0].score;

        }


        // --------------------------------------------
        // ONLINE PLAYERS
        // --------------------------------------------

        const onlinePlayers =
            await usersCollection.countDocuments({
                status: "online"
            });


        // --------------------------------------------
        // SEND RESPONSE
        // --------------------------------------------

        return res.status(200).json({

            success: true,

            totalPlayers: totalPlayers,

            onlinePlayers: onlinePlayers,

            gamesPlayed: gamesPlayed,

            highestScore: highestScore

        });

    }
    catch (error) {

        console.error(
            "Admin Stats Error:",
            error
        );

        return res.status(500).json({

            success: false,

            message: "Failed to load dashboard statistics."

        });

    }

});


// ============================================================
// ADMIN - GET ALL PLAYERS
// ============================================================

app.get('/api/admin/players', async (req, res) => {

    try {

        const players =
            await db.collection('users')
                .find({})
                .sort({ score: -1 })
                .toArray();


        const result =
            players.map(user => {

                return {

                    username:
                        user.username || "",

                    email:
                        user.email || "",

                    character:
                        user.character || "Default",

                    level:
                        user.currentLevel ||
                        user.level ||
                        1,

                    score:
                        user.score || 0,

                    gamesPlayed:
                        user.gamesPlayed || 0,

                    lastLogin:
                        user.lastLogin
                            ? new Date(user.lastLogin)
                                .toLocaleString()
                            : "Never",

                    status:
                        user.status || "offline"

                };

            });


        return res.status(200).json({

            success: true,

            players: result

        });

    }
    catch (error) {

        console.error(
            "Admin Players Error:",
            error
        );

        return res.status(500).json({

            success: false,

            message: "Failed to load players."

        });

    }

});


// ============================================================
// ADMIN - SEARCH PLAYERS
// ============================================================

app.get('/api/admin/search', async (req, res) => {

    try {

        const search =
            String(
                req.query.search || ""
            ).trim();


        if (!search) {

            return res.status(400).json({

                success: false,

                message: "Search text is required."

            });

        }


        const players =
            await db.collection('users')
                .find({

                    $or: [

                        {
                            username: {
                                $regex: search,
                                $options: "i"
                            }
                        },

                        {
                            email: {
                                $regex: search,
                                $options: "i"
                            }
                        }

                    ]

                })
                .sort({ score: -1 })
                .toArray();


        const result =
            players.map(user => {

                return {

                    username:
                        user.username || "",

                    email:
                        user.email || "",

                    character:
                        user.character || "Default",

                    level:
                        user.currentLevel ||
                        user.level ||
                        1,

                    score:
                        user.score || 0,

                    gamesPlayed:
                        user.gamesPlayed || 0,

                    lastLogin:
                        user.lastLogin
                            ? new Date(user.lastLogin)
                                .toLocaleString()
                            : "Never",

                    status:
                        user.status || "offline"

                };

            });


        return res.status(200).json({

            success: true,

            players: result

        });

    }
    catch (error) {

        console.error(
            "Admin Search Error:",
            error
        );

        return res.status(500).json({

            success: false,

            message: "Search failed."

        });

    }

});

// =====================================================
// GET PROFILE API
// =====================================================
//
// URL:
// /api/profile/:userId
//
// This profile API gets:
// 1. Basic player information from users
// 2. Score and level information from Collectioncode
// 3. Games played from Collectioncode
// 4. Wins / losses from Collectioncode
// 5. Highest score from Collectioncode
// 6. XP / challenges solved from challenge records
// 7. Recent games from Collectioncode
//
// =====================================================
// ============================================================
// PROFILE API
// GET PROFILE USING USERNAME
// Uses existing users and Collectioncode collections
// ============================================================
app.get('/api/profile', async (req, res) => {
    try {
        const username = req.query.username;
        const queryFilter = { username: { $regex: new RegExp(`^${username}$`, 'i') } };

        // 1. Fetch User Profile
        const user = await db.collection('users').findOne(queryFilter);
        if (!user) {
            return res.status(404).json({ success: false, message: 'User not found' });
        }

        // 2. Fetch Game Sessions (e.g. Sabitha documents)
        const gameSessions = await db.collection('Collectioncode').find(queryFilter).sort({ createdAt: -1 }).toArray();

        // 3. Fetch Code Submissions (e.g. Subhashini documents)
        const codeSubmissions = await db.collection('Collectioncode').find(queryFilter).sort({ submittedAt: -1 }).toArray();

        let recentGames = [];

        // Build list from game_sessions if available
        if (gameSessions.length > 0) {
            recentGames = gameSessions.map(s => ({
                level: s.level || 1,
                gameScore: s.score || 0,
                completed: s.completed || false,
                dateString: s.createdAt ? new Date(s.createdAt).toLocaleDateString('en-GB', { day: '2-digit', month: 'short' }) : 'Today'
            }));
        } 
        // Build list from code_submissions if available
        else if (codeSubmissions.length > 0) {
            recentGames = codeSubmissions.map(c => ({
                level: c.level || 1,
                gameScore: c.scoreEarned !== undefined ? c.scoreEarned : (c.score || 0),
                completed: c.passed || false,
                dateString: c.submittedAt ? new Date(c.submittedAt).toLocaleDateString('en-GB', { day: '2-digit', month: 'short' }) : 'Today'
            }));
        }

        // Calculate metrics
        let totalCodesCollected = 0;
        gameSessions.forEach(s => {
            if (Array.isArray(s.collectedCodes)) {
                totalCodesCollected += s.collectedCodes.length;
            }
        });

        let totalWins = 0;
        gameSessions.forEach(s => { if (s.completed) totalWins++; });
        codeSubmissions.forEach(c => { if (c.passed) totalWins++; });

        const totalGamesPlayed = Math.max(gameSessions.length, codeSubmissions.length);

        res.json({
            success: true,
            user: {
                _id: user._id ? user._id.toString() : '',
                username: user.username,
                currentLevel: user.currentLevel || user.level || 1,
                score: user.score || 0,
                xp: user.xp || 0
            },
            totalCodesCollected: totalCodesCollected,
            totalGamesPlayed: totalGamesPlayed,
            totalWins: totalWins,
            recentGames: recentGames.slice(0, 5) // Return top 5 recent entries
        });

    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});
// ==============================
// START SERVER
// ==============================
connectMongoDB()
    .then(() => {

        app.listen(PORT, () => {

            console.log(
                `Node.js API running at http://localhost:${PORT}`
            );

        });

    })
    .catch(error => {

        console.error(
            'Server startup failed:',
            error
        );

    });