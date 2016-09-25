
CREATE  TABLE users (
  id INT NOT NULL ,
  username VARCHAR(45) NOT NULL ,
  password VARCHAR(45) NOT NULL ,
  enabled TINYINT NOT NULL DEFAULT 1 ,
  PRIMARY KEY (id) ,
  UNIQUE KEY (username));

INSERT INTO users(username,password,enabled,role)
VALUES ('vaibhav','vaibhav123', true, 'ROLE_USER');
INSERT INTO users(username,password,enabled,role)
VALUES ('anamika','anamika123', true, 'ROLE_USER');