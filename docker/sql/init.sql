SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('ADMIN', 'TECHNICIAN') NOT NULL DEFAULT 'TECHNICIAN',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  brand VARCHAR(100) NOT NULL,
  model VARCHAR(100) NOT NULL,
  serial_number VARCHAR(100) NULL,
  weight_kg DECIMAL(6,2) NOT NULL DEFAULT 0.00,
  status ENUM('AVAILABLE', 'IN_SERVICE', 'DAMAGED') NOT NULL DEFAULT 'AVAILABLE',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_equipment_category FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS vehicles;
CREATE TABLE vehicles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  plate_number VARCHAR(20) NOT NULL UNIQUE,
  max_payload_kg INT NOT NULL,
  drive_axle ENUM('FRONT', 'BACK', '4x4') NOT NULL DEFAULT 'FRONT',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS events;
CREATE TABLE events (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  location VARCHAR(150) NOT NULL,
  event_date DATE NOT NULL,
  vehicle_id INT NULL,
  status ENUM('PLANNED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'PLANNED',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_events_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;

-- heslo je: Heslo123

INSERT INTO users (id, username, email, password, role) VALUES
(1, 'admin', 'admin@sonusbox.sk', '$2y$10$wIe1M4yFqMhF5z0gW9Gjke7gZ7rVzE8hPj7m2l1K6kZ8hJ9o6m1uW', 'ADMIN'),
(2, 'technik', 'technik@sonusbox.sk', '$2y$10$wIe1M4yFqMhF5z0gW9Gjke7gZ7rVzE8hPj7m2l1K6kZ8hJ9o6m1uW', 'TECHNICIAN');

INSERT INTO categories (id, name, description) VALUES
(1, 'Mikrofony', 'Vokalove a nastrojove mikrofony, bezdrotove sety, anteny'),
(2, 'Mixazne pulty a stageboxy', 'Digitalne mixy, stageboxy, digitalne hady'),
(3, 'PA Reproduktory a Subwoofery', 'Aktivne a pasivne reproboxy, line-array moduly'),
(4, 'Kabelaz a prislusenstvo', 'XLR, Speakon, Powercon, stojany na mikrofony');

INSERT INTO equipment (category_id, brand, model, serial_number, weight_kg, status) VALUES
(1, 'Shure', 'SM58', 'SH-SM58-001', 0.30, 'AVAILABLE'),
(1, 'Sennheiser', 'e945', 'SN-E945-891', 0.33, 'AVAILABLE'),
(2, 'Behringer', 'X32 Compact', 'BH-X32C-554', 15.40, 'AVAILABLE'),
(2, 'Midas', 'M32R', 'MD-M32R-102', 17.50, 'IN_SERVICE'),
(3, 'RCF', 'ART 932-A', 'RCF-932-099', 18.80, 'AVAILABLE'),
(3, 'RCF', 'SUB 8003-AS II', 'RCF-SUB8-11', 45.00, 'AVAILABLE'),
(4, 'Klotz', 'XLR 10m Box (20ks)', 'CB-XLR-10M', 12.00, 'AVAILABLE');

INSERT INTO vehicles (id, name, plate_number, max_payload_kg, drive_axle) VALUES
(1, 'Mercedes-Benz Sprinter 316 CDI', 'ZA-842EA', 1350, 'BACK'),
(2, 'Iveco Daily 35S18', 'ZA-119DF', 1100, 'BACK'),
(3, 'Volkswagen Transporter T6', 'ZA-554CB', 850, '4x4');

INSERT INTO events (name, location, event_date, vehicle_id, status) VALUES
('Ples Fakulty Riadenia a Informatiky', 'Zilina - Event House', '2026-11-15', 1, 'PLANNED'),
('Rockovy festival Terchova', 'Amfiteater Nad borami, Terchova', '2026-07-20', 1, 'PLANNED'),
('Koncert v Mestskom divadle', 'Mestske divadlo Zilina', '2026-10-05', 3, 'COMPLETED');