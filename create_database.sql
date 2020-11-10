SET AUTOCOMMIT = ON;
drop database if exists meeting_project;
CREATE DATABASE meeting_project ENCODING 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8';
select meeting_project;

create table Role(
	id SERIAL primary key,
    role_type varchar(255)
);

create table Company(
	id SERIAL primary key,
    company_name varchar(255),
    license_number varchar(100),
    number_of_members int
);

create table Department(
id SERIAL primary key,
    department_name varchar(100),
    number_of_members smallint,
    manager_id int,
    company_id int,
    foreign key(company_id) references Company(id) on update cascade on delete cascade
);

create table Room(
	id SERIAL primary key,
    room_name varchar(100),
    is_multi_access boolean,
    opened_time varchar(255),
    closed_time varchar(255),
    building varchar(50),
    capacity int
);

create table Device(
	id SERIAL primary key,
    device_name varchar(255),
    buy_time varchar(255),
    liquidation_time varchar(255),
    buy_price decimal(19,4),
    liquidation_price decimal(19,4),
    room_id int,
    number_devices int,
    specifications varchar(255),
    device_status tinyint,
    foreign key(room_id) references Room(id) on update cascade on delete cascade
);

create table Employee(
	id SERIAL primary key,
    email varchar(50) not null unique,
    full_name varchar(255),
	refresh_token varchar(50),
    avatar_url varchar(255)
);

create table RoleEmployee(
	role_id int,
    employee_id int,
    primary key(role_id, employee_id),
    foreign key(employee_id) references Employee(id) on update cascade on delete cascade,
    foreign key(role_id) references Role(id) on update cascade on delete cascade
);

alter table Employee add department_id int;
alter table Employee add foreign key (department_id) references Department(id) on update cascade on delete cascade;
alter table Department add foreign key (manager_id) references Employee(id) on update cascade on delete cascade;

create table Meeting(
	id SERIAL primary key,
    meeting_title varchar(255),
    meeting_description varchar(255),
    creator_id int,
    is_periodic boolean,
    state tinyint,
    room_id int,
    started_time datetime,
    finished_time datetime,
    foreign key(room_id) references Room(id) on update cascade on delete cascade,
    foreign key(creator_id) references Employee(id) on update cascade on delete cascade
);

create table MeetingEmployee(
	meeting_id int,
    employee_id int,
    is_accepted boolean,
    is_coordinator boolean,
    may_join tinyint,
    primary key(meeting_id, employee_id),
    foreign key(meeting_id) references Meeting(id) on update cascade on delete cascade,
    foreign key(employee_id) references Employee(id) on update cascade on delete cascade
);

create table Project(
	id SERIAL primary key,
    project_name varchar(255),
    started_time datetime,
    finished_time datetime,
    estimated_budget decimal(19,4),
    actual_cost decimal(19,4),
    number_of_members int,
    manager_id int,
    foreign key(manager_id) references Employee(id) on update cascade on delete cascade
);

create table ProjectEmployee(
	project_id int,
    employee_id int,
    join_time varchar(255),
    eject_time varchar(255),
    role_in_project varchar(255),
    primary key(project_id, employee_id),
    foreign key(project_id) references Project(id) on update cascade on delete cascade,
    foreign key(employee_id) references Employee(id) on update cascade on delete cascade
);
