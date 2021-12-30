UPDATE `uic_product` SET `product_name` = 'EasyDO',`product_url` = 'https://easydo.dtstack.com',`product_code` = 'EASYDO',`prodcut_desc` = '数据化运维平台',`product_img_url` = 'imgs/easydo_logo.png' WHERE `product_name` = 'DTsmart';
UPDATE `uic_tenant_product_rel` SET `product_code`='EASYDO' WHERE `product_code`='DTSMART';
UPDATE `uic_tenant_product_renew_record` SET `product_code`='EASYDO' WHERE `product_code`='DTSMART';
UPDATE `uic_user_product_rel` SET `product_code`='EASYDO' WHERE `product_code`='DTSMART';
