create database IbuMayaApp;
Use IbuMayaApp

-- DDL
create table User (
	id int auto_increment primary key,
    nama varchar(100),
    email varchar(100) unique,
    password varchar(255),
    usia int,
    pekerjaan varchar(100),
    lokasi varchar(100)
);

CREATE TABLE activities (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    deskripsi VARCHAR(255),
    waktu DATE,
    kategori ENUM('Pekerjaan', 'Keluarga', 'Hobi'),
    id INT,
    FOREIGN KEY (id) REFERENCES User(id) ON DELETE CASCADE
);

CREATE TABLE health (
    health_id INT AUTO_INCREMENT PRIMARY KEY,
    aktivitas VARCHAR(100),
    durasi INT,  -- durasi dalam menit
    kalori_terbakar INT,
    tanggal DATE,
    id INT,
    FOREIGN KEY (id) REFERENCES User(id) ON DELETE CASCADE
);

CREATE TABLE task (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    deskripsi VARCHAR(255),
    kategori ENUM('Pekerjaan', 'Keluarga', 'Pribadi'),
    status ENUM('Pending', 'Selesai'),
    deadline DATE,
    id INT,
    FOREIGN KEY (id) REFERENCES User(id) ON DELETE CASCADE
);

CREATE TABLE meal_schedule (
    meal_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_makanan VARCHAR(100),
    waktu_makan ENUM('Sarapan', 'Makan Siang', 'Makan Malam', 'Snack'),
    kalori INT,
    child_name VARCHAR(100),  
    id INT, 
    FOREIGN KEY (id) REFERENCES User(id) ON DELETE CASCADE
);

-- DML
INSERT INTO User (nama, email, password, usia, pekerjaan, lokasi) 
VALUES ('Maya', 'maya@gmail.com', 'password123', 37, 'Direktur Pemasaran', 'Jakarta Pusat');

INSERT INTO activities (deskripsi, waktu, kategori, id) 
VALUES ('Meeting Pemasaran', '2024-09-28', 'Pekerjaan', 1), 
       ('Mengantar anak ke sekolah', '2024-09-29', 'Keluarga', 1),
       ('Bermain piano', '2024-09-30', 'Hobi', 1);
       
INSERT INTO health (aktivitas, durasi, kalori_terbakar, tanggal, id) 
VALUES ('Lari Maraton', 120, 1000, '2024-09-27', 1);

INSERT INTO task (deskripsi, kategori, status, deadline, id) 
VALUES ('Membuat laporan penjualan', 'Pekerjaan', 'Pending', '2024-10-01', 1), 
       ('Mengantar Lily ke sekolah', 'Keluarga', 'Pending', '2024-09-30', 1),
       ('Latihan piano', 'Pribadi', 'Selesai', '2024-09-25', 1);
       
INSERT INTO meal_schedule (nama_makanan, waktu_makan, kalori, child_name, id) 
VALUES ('Nasi goreng sayur', 'Makan Siang', 500, 'Lily', 1), 
       ('Sandwich alpukat', 'Sarapan', 300, 'Leo', 1);
       
UPDATE User
SET pekerjaan = 'CEO'
WHERE id = 1;     

SELECT * FROM activities WHERE kategori = 'Pekerjaan';
SELECT * FROM task WHERE status = 'Pending';

DELIMITER //
CREATE PROCEDURE SP_Tambah_User(
    IN p_nama VARCHAR(100), 
    IN p_email VARCHAR(100), 
    IN p_password VARCHAR(255), 
    IN p_usia INT, 
    IN p_pekerjaan VARCHAR(100), 
    IN p_lokasi VARCHAR(100)
)
BEGIN
    INSERT INTO User (nama, email, password, usia, pekerjaan, lokasi) 
    VALUES (p_nama, p_email, p_password, p_usia, p_pekerjaan, p_lokasi);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_Cari_User_Nama(
    IN p_nama VARCHAR(100)
)
BEGIN
    SELECT * FROM User WHERE nama = p_nama;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_Delete_User(
    IN p_id INT
)
BEGIN
    DELETE FROM User WHERE id = p_id;
END //
DELIMITER ;

CALL SP_Tambah_User('Maya', 'maya1@gmail.com', 'password123', 37, 'Direktur Pemasaran', 'Jakarta Pusat');

SELECT * FROM User;

DELIMITER //
CREATE PROCEDURE SP_Tambah_Activities(
    IN p_deskripsi VARCHAR(255), 
    IN p_waktu DATE, 
    IN p_kategori ENUM('Pekerjaan', 'Keluarga', 'Hobi'), 
    IN p_id INT
)
BEGIN
    INSERT INTO activities (deskripsi, waktu, kategori, id) 
    VALUES (p_deskripsi, p_waktu, p_kategori, p_id);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_Tambah_Health(
    IN p_aktivitas VARCHAR(100), 
    IN p_durasi INT, 
    IN p_kalori_terbakar INT, 
    IN p_tanggal DATE, 
    IN p_id INT
)
BEGIN
    INSERT INTO health (aktivitas, durasi, kalori_terbakar, tanggal, id) 
    VALUES (p_aktivitas, p_durasi, p_kalori_terbakar, p_tanggal, p_id);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_Tambah_Task(
    IN p_deskripsi VARCHAR(255), 
    IN p_kategori ENUM('Pekerjaan', 'Keluarga', 'Pribadi'), 
    IN p_status ENUM('Pending', 'Selesai'), 
    IN p_deadline DATE, 
    IN p_id INT
)
BEGIN
    INSERT INTO task (deskripsi, kategori, status, deadline, id) 
    VALUES (p_deskripsi, p_kategori, p_status, p_deadline, p_id);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_Tambah_Meal_Schedule(
    IN p_nama_makanan VARCHAR(100), 
    IN p_waktu_makan ENUM('Sarapan', 'Makan Siang', 'Makan Malam', 'Snack'), 
    IN p_kalori INT, 
    IN p_child_name VARCHAR(100), 
    IN p_id INT
)
BEGIN
    INSERT INTO meal_schedule (nama_makanan, waktu_makan, kalori, child_name, id) 
    VALUES (p_nama_makanan, p_waktu_makan, p_kalori, p_child_name, p_id);
END //
DELIMITER ;

SELECT * FROM activities WHERE kategori = 'Pekerjaan';
SELECT * FROM task WHERE status = 'Pending';

