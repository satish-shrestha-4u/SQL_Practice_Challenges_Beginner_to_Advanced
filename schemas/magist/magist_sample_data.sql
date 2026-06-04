-- Magist Sample Data
-- Small sample rows extracted from the original dump for GitHub readability.
-- Full original data dump is not included because of file size limitations.

-- Sample rows for `customers`
INSERT INTO `customers` VALUES
('06b8999e2fba1a1fbc88172c00ba8bc7', '861eff4711a542e4b93843c6dd7febb0', 14409),
('18955e83d337fd6b2def6b18a428ac77', '290c77bc529b7ac935b93aa66c333dc3', 9790),
('4e7b3e00288586ebd08712fdd0374a03', '060e732b5b29e8181a18229c7b0b2b5e', 1151),
('b2b6027bc5c5109e529d4dc6358b12c3', '259dac757896d24d7702b9acbbff3f3c', 8775),
('4f2d8ab171c80ec8364f7c12e35b23ad', '345ecd01c38d18a9036ed96c73b8d066', 13056);

-- Sample rows for `geo`
INSERT INTO `geo` VALUES
(1001,'sao paulo','SP',-23.5502,-46.6340),
(1002,'sao paulo','SP',-23.5481,-46.6350),
(1003,'sao paulo','SP',-23.5490,-46.6357),
(1004,'sao paulo','SP',-23.5498,-46.6348),
(1005,'sao paulo','SP',-23.5495,-46.6367);

-- Sample rows for `order_items`
INSERT INTO `order_items` VALUES
('00010242fe8c5a6d1ba2dd792cb16214',1,'4244733e06e7ecb4970a6e2683c13e61','48436dade18ac8b2bce089ec2a041202','2017-09-19 09:45:35',58.9,13.29),
('00018f77f2f0320c557190d7a144bdd3',1,'e5f2d52b802189ee658865ca93d83a8f','dd7ddc04e1b6c2c614352b383efe2d36','2017-05-03 11:05:13',239.9,19.93),
('000229ec398224ef6ca0657da4fc703e',1,'c777355d18b72b67abbeef9df44fd0fd','5b51032eddd242adc84c38acab88f23d','2018-01-18 14:48:30',199,17.87),
('00024acbcdf0a6daa1e931b038114c75',1,'7634da152a4610f1595efa32f14722fc','9d7a1d34a5052409006425275ba1c2b4','2018-08-15 10:10:18',12.99,12.79),
('00042b26cf59d7ce69dfabb4e55b4fd9',1,'ac6c3623068f30de03045865e4e10089','df560393f3a51e74553ab94004ba5c87','2017-02-13 13:57:51',199.9,18.14);

-- Sample rows for `order_payments`
INSERT INTO `order_payments` VALUES
('b81ef226f3fe1789b1e8b2acac839d17',1,'credit_card',8,99.33),
('a9810da82917af2d9aefd1278f1dcfa0',1,'credit_card',1,24.39),
('25e8ea4e93396b6fa0d3dd708e76c1bd',1,'credit_card',1,65.71),
('ba78997921bbcdc1373bb41e913ab953',1,'credit_card',8,107.78),
('42fdf880ba16b47b59251dd489d4441a',1,'credit_card',2,128.45);

-- Sample rows for `order_reviews`
INSERT INTO `order_reviews` VALUES
('0001239bc1de2e33cb583967c2ca4c67','fc046d7776171871436844218f817d7d',5,NULL,NULL,'2018-03-20 00:00:00','2018-03-20 18:36:04'),
('0001cc6860aeaf5b9017fe4131a52e62','d4665434b01caa9dc3e3e78b3eb3593e',5,NULL,NULL,'2018-06-22 00:00:00','2018-06-26 13:51:29'),
('00020c7512a52e92212f12d3e37513c0','e28abf2eb2f1fbcbdc2dd0cd9a561671',5,'Entrega rápida!','A entrega foi super rápida e o pendente é lindo! Igual a foto mesmo! ','2018-04-25 00:00:00','2018-04-26 14:55:36'),
('00032b0141443497c898b3093690af51','04fb47576993a3cb0c12d4b25eab6e4e',5,NULL,NULL,'2017-05-30 00:00:00','2017-06-01 23:28:55'),
('00034d88989f9a4c393bdcaec301537f','5f358d797a49fe2f24352f73426215f6',5,NULL,NULL,'2017-08-12 00:00:00','2017-08-13 19:56:53');

-- Sample rows for `orders`
INSERT INTO `orders` VALUES
('00010242fe8c5a6d1ba2dd792cb16214','3ce436f183e68e07877b285a838db11a','delivered','2017-09-13 08:59:02','2017-09-13 09:45:35','2017-09-19 18:34:16','2017-09-20 23:43:48','2017-09-29 00:00:00'),
('00018f77f2f0320c557190d7a144bdd3','f6dd3ec061db4e3987629fe6b26e5cce','delivered','2017-04-26 10:53:06','2017-04-26 11:05:13','2017-05-04 14:35:00','2017-05-12 16:04:24','2017-05-15 00:00:00'),
('000229ec398224ef6ca0657da4fc703e','6489ae5e4333f3693df5ad4372dab6d3','delivered','2018-01-14 14:33:31','2018-01-14 14:48:30','2018-01-16 12:36:48','2018-01-22 13:19:16','2018-02-05 00:00:00'),
('00024acbcdf0a6daa1e931b038114c75','d4eb9395c8c0431ee92fce09860c5a06','delivered','2018-08-08 10:00:35','2018-08-08 10:10:18','2018-08-10 13:28:00','2018-08-14 13:32:39','2018-08-20 00:00:00'),
('00042b26cf59d7ce69dfabb4e55b4fd9','58dbd0b2d70206bf40e62cd34e84d795','delivered','2017-02-04 13:57:51','2017-02-04 14:10:13','2017-02-16 09:46:09','2017-03-01 16:42:31','2017-03-17 00:00:00');

-- Sample rows for `product_category_name_translation`
INSERT INTO `product_category_name_translation` VALUES
('agro_industria_e_comercio','agro_industry_and_commerce'),
('alimentos','food'),
('alimentos_bebidas','food_drink'),
('artes','art'),
('artes_e_artesanato','arts_and_craftmanship');

-- Sample rows for `products`
INSERT INTO `products` VALUES
('00066f42aeeb9f3007548bb9d3f33c38','perfumaria',53,596,6,300,20,16,16),
('00088930e925c41fd95ebfe695fd2655','automotivo',56,752,4,1225,55,10,26),
('0009406fd7479715e4bef61dd91f2462','cama_mesa_banho',50,266,2,300,45,15,35),
('000b8f95fcb9e0096488278317764d19','utilidades_domesticas',25,364,3,550,19,24,12),
('000d9be29b5207b54e86aa1b1ac54872','relogios_presentes',48,613,4,250,22,11,15);

-- Sample rows for `sellers`
INSERT INTO `sellers` VALUES
('8602a61d680a10a82cceeeda0d99ea3d',1001),
('dd55f1bb788714a40e7954c3be6df745',1021),
('e0487761face83d64fcada2408959a36',1021),
('09bad886111255c5b5030314fc7f1a4a',1022),
('82921991ff5b557b045605b8bbf08d49',1023);

