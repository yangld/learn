ALTER TABLE user_info add INDEX area_code (area_code);
ALTER TABLE user_info ADD INDEX name (name);
ALTER TABLE user_info	ADD INDEX id_no (id_no);
ALTER TABLE user_info ADD COLUMN area_name VARCHAR(255);


UPDATE user_info u INNER JOIN v_province_info v on u.area_code = v.area_code set u.area_name = v.area_name ;
    
ALTER TABLE terminal_info add INDEX activate_time (activate_time);
ALTER TABLE terminal_info ADD COLUMN area_code VARCHAR(255);
ALTER TABLE terminal_info ADD COLUMN area_name VARCHAR(255);
ALTER TABLE terminal_info ADD COLUMN violation_status int(1) DEFAULT '1';
ALTER TABLE terminal_info ADD COLUMN connect_time datetime(3) DEFAULT NULL;
UPDATE terminal_info t INNER JOIN v_province_info v on t.cmc_id = v.cmc_id 
  set t.area_code = v.area_code, t.area_name = v.area_name;

ALTER TABLE terminal_info add INDEX terminal_id (terminal_id);
ALTER TABLE terminal_status_info add INDEX terminal_id (terminal_id);
UPDATE terminal_info t INNER JOIN terminal_status_info ts on t.terminal_id = ts.terminal_id
  set t.violation_status = ts.violation_status, t.connect_time= ts.connect_time;

ALTER TABLE terminal_status_info ADD INDEX connect_time (connect_time);

ALTER TABLE security_event_info add INDEX event_time (event_time);
ALTER TABLE security_event_info ADD COLUMN area_code VARCHAR(255);
ALTER TABLE security_event_info ADD COLUMN area_name VARCHAR(255);
UPDATE security_event_info s INNER JOIN v_province_info v on s.cmc_id = v.cmc_id 
  set s.area_code = v.area_code, s.area_name = v.area_name;

-- 第二次升级需要运行
UPDATE user_info u INNER JOIN v_province_info v 
	ON u.cmc_id=v.cmc_id set u.area_code = v.area_code, u.area_name = v.area_name;

UPDATE user_info SET user_type = 2 WHERE user_type != 1 and user_type !=2;