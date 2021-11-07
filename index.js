const express = require('express');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const mysql = require('mysql');
const cors = require('cors');
const verify = require('./verify');
require('dotenv').config();

const app = express();
app.use(bodyParser.json());
app.use(cors());

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'bluestack'
});

app.post('/', (req, res) => {
    res.status(200).send();
});

app.post('/signin', (req, res) => {
    const username = req.body.username || "";
    const password = req.body.password || "";

    connection.query('SELECT * FROM users WHERE username=?', [username], (err, result) => {
        if(err) throw err;
        bcrypt.compare(password, result[0].password, (error, compareResult) => {
            if(error) res.status(403).json(error);
            if(compareResult) {
                const token = jwt.sign({username: result[0].username, email: result[0].email, name: result[0].name, surname: result[0].surname, phoneNumber: result[0].phoneNumber, role: result[0].role}, process.env.JWT_SECRET);
                const details = jwt.verify(token, process.env.JWT_SECRET);
                res.status(200).json({token: token, details: details});
            } else {
                res.status(403).json({error: "Please check your username and password"});
            }
        });
    });
});

app.post('/register', (req, res) => {
    const username = req.body.username;
    const password = req.body.password;
    const email = req.body.email;
    const name = req.body.name;
    const surname = req.body.surname;
    const phoneNumber = req.body.phoneNumber;

    connection.query("SELECT * FROM users WHERE username=?", [username], (checkUserError, checkUser) => {
        if(checkUserError) res.status(403).send(checkUserError);
        if(checkUser.length >= 1) {
            res.status(403).send('Username already exists!');
        } else {
            bcrypt.genSalt(12, (err, salt) => {
                if(err) res.status(403).send(err);
                bcrypt.hash(password, salt, (error, hash) => {
                    if(error) res.status(403).send(error);
                    connection.query('INSERT INTO users(username, password, email, name, surname, phoneNumber, role) VALUES (?, ?, ?, ?, ?, ?, ?)', [username, hash, email, name, surname, phoneNumber, "employee"], (dbError, dbResult) => {
                        if(dbError) res.status(403).send(dbError);
                        res.status(200).send();
                    });
                });
            });
        }
    })
});

app.post('/updateJobs', (req, res) => {
    let items = req.body.added[0];

    connection.query("INSERT INTO jobs(Id, Subject, Location, StartTime, EndTime, IsAllDay, Description, RecurrenceRule) VALUES(?,?,?,?,?,?,?,?)", [
        items.Id, items.Subject, items.Location, items.StartTime, items.EndTime, items.IsAllDay, items.Description, items.RecurrenceRule
    ], (err, result) => {
        if(err) throw err;
    });
});

app.post('/getJobs', (req, res) => {
    connection.query("SELECT * FROM jobs", (err, result) => {
        if(err) throw err;
        res.status(200).json(result);
    })
});

app.post('/addProduct', (req, res) => {
    const product_name = req.body.product_name;
    const in_stock = req.body.in_stock;

    connection.query("INSERT INTO stock(product_name, in_stock) VALUES (?, ?)", [product_name, in_stock],(err, result) => {
        if(err) throw err;
        res.status(200).json({status: 200, message: 'Added Product'});
    });
});

app.get('/getProducts', (req, res) => {
    connection.query("SELECT * FROM stock", (err, results) => {
        if(err) throw err;
        res.status(200).json(results);
    });
});

app.get('/getProduct/:id', (req, res) => {
    const product_id = req.params.id;

    connection.query("SELECT * FROM stock WHERE id=?", [product_id], (err, results) => {
        if(err) throw err;
        res.status(200).json(results);
    });
});

app.post('/edit/:id', (req, res) => {
    const product_id = req.params.id;
    const name = req.body.name;
    const stock = req.body.stock;

    connection.query("UPDATE stock SET product_name=?, in_stock=? WHERE id=?", [name, stock, product_id], (err, result) => {
        if(err) throw err;
        res.status(200).json({status:200, message: 'Updated'});
    });
});

app.get('/checkUser/:token', (req, res) => {
    const token = req.params.token;
    const verified = jwt.verify(token, process.env.JWT_SECRET);
    console.log(verified)
    if(verified) {
        res.status(200).json({status: 200, token: token, details: verified});
    } else {
        res.status(403).json({status: 403, token: ""});
    }
});

app.get('/getEmployees/:username', (req, res) => {
    const username = req.params.username;

    connection.query("SELECT * FROM users WHERE username!=?", [username], (err, result) => {
        if(err) throw err;
        res.status(200).json(result);
    });
});

app.post('/addTool/complete', verify, (req, res) => {
    const tool = req.body.tool;
    const category = req.body.category;
    const car = req.body.car;
    const amount = req.body.amount;

    connection.query("INSERT INTO tools(tool, category, car, amount) VALUES(?, ?, ?, ?)", [tool, category, car, amount], (err, result) => {
        if(err) res.status(400).json({status: 400, message: err});
        else res.status(200).json({status: 200, message: 'Added successfully'});
    });
});

app.get('/addTool/info', (req, res) => {
    connection.query("SELECT * FROM cars", (err, car) => {
        if(err) res.status(400).json({status: 400, message: "Bad Request, please refresh"});
        else connection.query("SELECT * FROM tool_category", (error, category) => {
            if(error) res.status(400).json({status: 400, message: "Bad Request, please refresh"});
            else res.status(200).json({status: 200, cars: car, categories: category});
        });
    });
});

app.get('/getCars', (req, res) => {
    connection.query("SELECT * FROM cars", (err, result) => {
        if(err) throw err;
        res.status(200).json(result);
    });
});

app.get('/getTools', (req, res) => {
    connection.query("SELECT * FROM tools", (err, result) => {
        if(err) throw err;
        res.status(200).json(result);
    });
});

app.get('/getOneCar', (req, res) => {
    // Create connection and get the first entry from table cars
    connection.query("SELECT * FROM cars LIMIT 1", (err, result) => {
        if(err) throw err;
        res.status(200).json(result);
    });
})

app.listen(3001);