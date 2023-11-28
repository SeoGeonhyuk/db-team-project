const express = require('express');
const app = express();
const server = require("http").createServer(app);
const mysql = require('mysql');
const qs = require("node:querystring");
const path = require("path");
const bodyParser = require("body-parser");
//사전에 node.js를 설치할 것
//api 실행을 위해서는 해당 DB_api 폴더 내부에서
//sudo npm install(최초 한 번만 오류 생기면 다시) 진행 후
//sudo node index.js 실행
//그렇게 하면 서버가 실행되며 서버를 종료하고 싶을 경우에는 컨트롤+c
//테스트 툴은 포스트맨 추천
//db 사용전에 반드시 https://devpouch.tistory.com/114를 참고할 것
//db sql파일은 db폴더 내부에 존재
const db = {
    user : {
        host: 'localhost',
        //db 폴더에 있는 db를 활용하여 각자 db폴더를 업데이트 할 것
        //다른 사람들에게 db파일을 공유해주고 싶다면 mysqldump라는 유틸리티를 찾아볼 것
        //각자의 db user와 password입력
        user: 'root',
        password: 'rhdrhdCLF',
        database: 'user'
    },
    music : {
        host: 'localhost',
        //db 폴더에 있는 db를 활용하여 각자 db폴더를 업데이트 할 것
        //다른 사람들에게 db파일을 공유해주고 싶다면 mysqldump라는 유틸리티를 찾아볼 것
        //각자의 db user와 password입력
        user: 'root',
        password: 'rhdrhdCLF',
        database: 'music'
    }
}

const connection = mysql.createConnection(db.user);
connection.connect((err) => {
    if (err) {
      console.error('MySQL connection failed: ' + err.stack);
      return;
    }
    console.log('Connected to MySQL database');
  });
app.use(bodyParser.json());




//로그인 api
//body로 보내줘야 할 것:email, password
app.post("/login", (req, res) => {
    console.log("login api 동작");
    const {email, password} = req.body;
    connection.query(`USE ${db.user.database}`, (err) => {
        if(err){
            console.error('Error switching database:', err);
            res.status(500).send("Internal Server Error!");
        }
        else{
            const login_Query = `SELECT * FROM USER WHERE Email = ${connection.escape(email)} AND Password_hash = ${connection.escape(password)}`;
            connection.query(login_Query, (err, results) => {
                if (err) {
                    console.error('Error executing SELECT query:', err);
                    res.status(500).send("Internal Server Error!");
                } else {
                    if( results == null || results == undefined || results.length == 0 ){
                        res.status(401).send("Login Failed!");
                    }
                    else{
                        res.status(200).send("Login Success!");
                    }
                }
            });
        }    
    });        
});

//회원 가입 api
//body로 보내주어야 할 것 : (email, password)
app.post("/register", (req, res) => {
    const {email, password} = req.body;
    connection.query(`USE ${db.user.database}`, (err) => {
        if (err){
            console.error('Error switching database:', err);
            res.status(500).send("Internal Server Error!");
        }
        else{
            connection.query(`SELECT * FROM USER WHERE Email = ${connection.escape(email)}`, (err, user) => {
                if (err) {
                    console.error('Error executing SELECT query:', err);
                    res.status(500).send("Internal Server Error!");
                }
                else {
                    if (user.length == 0 || user == null || user == undefined) {
                        connection.query(`INSERT INTO USER (Email, Password_hash) VALUES (${connection.escape(email)}, ${connection.escape(password)})`, (err) => {
                            if (err) {
                                console.error('Error executing INSERT query:', err);
                                res.status(500).send("Internal Server Error!");
                                }
                            else {
                                res.status(200).send(`${email} 유저 회원 가입 완료`);
                            }
                        });
                    }
                    else {
                        res.status(400).send(`${email} 중복된 유저 확인`);
                    }
                }
            });
        }
    });
});


//모든 음악들을 가져오는 api
//query:필요없음
app.get("/musics", (req, res) => {
    connection.query(`USE ${db.music.database}`, (err) => {
        if (err){
            console.error('Error switching database:', err);
            res.status(500).send("Internal Server Error!");
        }
        else{
            allMusic_Query = `SELECT * FROM MUSIC`;
            connection.query(allMusic_Query, (err, results) => {
                if (err){
                    console.error('Error executing SELECT query:', err);
                    res.status(500).send("Internal Server Error!");
                }
                else{
                    console.log("모든 음악 가져오기 완료!");
                    res.status(200).send(results);
                }
            });
        }
    });
});

//각 유저의 좋아하는 음악들을 가져오는 api
//query로 보내줘야 할 것:email
//api를 사용할 때 /favorite-music?email=사용자의 이메일
//형식으로 요청해야 함
app.get("/favorite-music", (req, res) => {
    const {email} = req.query.email;
    const favorite_Query = `SELECT Music_ID_Liked FROM USER_FAVORITE WHERE Email = ${connection.escape(email)}`;
    connection.query(`USE ${db.user.database}`, (err) => {
        if (err){
            console.error('Error switching database:', err);
            res.status(500).send("Internal Server Error!");
        }
        else{
            connection.query(favorite_Query, (err, results) => {
                    if (err) {
                    console.error('Error executing SELECT query:', err);
                    res.status(500).send("Internal Server Error!");
                    } 
                    else {
                    console.log('SELECT Query Results:', results);
                    connection.query(`USE ${db.music.database}`, (err) => {
                        if (err) {
                            console.error('Error switching database:', err);
                            res.status(500).send("Internal Server Error!");
                        } else {
                            const MusicFull = [];
                            results.forEach(element => {
                                const favoriteMusicInformation_Query = `SELECT * FROM MUSIC WHERE Music_ID = ${element}`;
                                connection.query(favoriteMusicInformation_Query, (err, favoriteLists) => {
                                    if(err){
                                        res.status(500).send("Internal Server Error!");
                                    }
                                    else{
                                        MusicFull.push(favoriteLists);
                                    }
                                });
                            });
                            if(MusicFull.lenght === results.lenght)
                                res.status(200).send(MusicFull);
                        }          
                    });
                }
            });
        }
    });
});

//음악에 좋아요 버튼을 눌렀을 경우 해당 음악의 user favorite에 추가하는 api
//body로 보내주어야 할 것 : (email, music_id)
app.post("favorite-music", (req, res) => {
    const {email, music_id} = req.body;
    connection.query(`USE ${db.user}`, (err) => {
        if (err) {
            console.error('Error switching database:', err);
            res.status(500).send("Internal Server Error!");
        }
        else {
            connection.query(`INSERT INTO USER_FAVORITE (Email, Music_ID_Liked) VALUES (${connection.escape(email)}, ${connection.escape(music_id)})`, (err) => {
                if (err) {
                    console.error('Error executing INSERT query:', err);
                    res.status(500).send("Internal Server Error!");
                }
                else {
                    res.status(200).send(`${email} 사용자, ${music_id}를 좋아하는 음악 리스트에 추가 완료`);
                }
            });
        }
    });
});


//해당 음악을 터치했을 때 음악의 가사와 뮤직 비디오의 url을 가져오는 api(미완)
//query로 보내주어야 할 것 : (music_id)
app.get("/music-information", (req, res) => {
    const {music_id} = req.query.music_id;
    connection.query
});
//음악 추천 알고리즘(작성 부탁) => 그럼 해당 api로 변형하도록 함
const PORT = 80;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });