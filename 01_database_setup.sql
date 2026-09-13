CREATE DATABASE customer_support_analytics;

USE customer_support_analytics;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(100) NOT NULL,
    department VARCHAR(50)
);

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    agent_id INT NOT NULL,
    category VARCHAR(50),
    priority VARCHAR(20),
    created_date DATE,
    resolved_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

CREATE TABLE responses (
    response_id INT PRIMARY KEY,
    ticket_id INT NOT NULL,
    response_type VARCHAR(20),
    response_date DATETIME,
    response_time_min INT,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id)
);

CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY,
    ticket_id INT NOT NULL,
    rating INT,
    feedback_date DATE,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id)
);