-- criação do bd para e-commerce

create database if not exists ecommerce;
use ecommerce;

-- criar tabela cliente 

create table if not exists clients(
	idClient INT AUTO_INCREMENT   PRIMARY KEY NOT NULL,
    CPF char(11) NOT NULL,
    Fname varchar(45),
	Minit char(3),
    Lname varchar(45),
    Adress varchar(45),
    BirthDate DATE,
	constraint unique_client_cpf UNIQUE (CPF)
);
alter table clients auto_increment =1;
-- criar tabela produto 

create table if not exists product(
	idProduct INT PRIMARY KEY NOT NULL,
    Pname varchar(45),
	classification_kids bool default false,
    category enum('Eletronico','Brinquedos','Moda','Livros','Filmes','Móveis') not null,
    avaliacao float default 0,
    size varchar(10), #dimensão do produto 
    constraint unique_id_product unique (idProduct)
);

-- criar a tabela pagamentos 
-- desafio terminar de implementar a tabela e criar a conexão com as tabelas necessárias 
-- criar constraints relacionadas ao pagamento 

create table if not exists payments(
		idClient int, 
        idPayment int not null auto_increment, 
        typePayment enum('Boleto','Cartão','Dois cartões'),
        limitAvailable float,
        primary key (idClient,idPayment),
        constraint unique_idpayment unique(idPayment),
        constraint fk_client_id foreign key (idClient) references clients(idClient)
);

-- criar tabela pedido 
create table if not exists order_product(
	idOrder int not null primary key,
	idOrderClient int,
    idPayment int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') not null default 'Em processamento',
    orderDescription varchar(255),
    paymentCash bool default false,
    sendValue float default 10,
    constraint fk_payments_paymentId foreign key (idPayment) references payments(idPayment),
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient),
    constraint unique_id_order unique (idOrder)
);

-- criar tabela estoque 
create table if not exists productStorage(
	idProductStorage int auto_increment primary key not null,
	storageLocation varchar(255) not null,
    quantity int default 0
);


-- criar tabela fornecedor 
create table if not exists supplier(
	idSupplier int not null auto_increment primary key,
    SocialName varchar(255),
    CNPJ char(15) NOT NULL,
    contact char(15) not null,
    constraint unique_cnp unique (CNPJ),
	constraint unique_id_productStorage unique (idSupplier)
);


-- criar tabela vendedor 
create table if not exists seller(
	idSeller int auto_increment primary key,
    SocialName varchar(45),
    AbstName varchar(45),
    CNPJ char(15) not null,
    CPF char(9) not null,
    location varchar(255),
    contact char(11) not null,
    constraint unique_CNPJ unique (CNPJ),
    constraint unique_CPF unique (CPF),
    constraint unique_idSeller unique(idSeller)
);

-- criar tabela de relação ProductSeller

create table if not exists ProductSeller(
	idPSeller int, 
    idProduct int,
	prodQuantity int default 1,
	primary key (idPSeller, idProduct),
    constraint fk_product_seller_Pseller foreign key(idPSeller) references seller(idSeller),
    constraint fk_product_seller_product foreign key(idProduct) references product(idProduct)
);

-- criar relação produto/pedido
create table if not exists productOrder(
	idPOproduct int, 
    idPOorder int, 
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct,idPOorder),
    constraint fk_POproduct foreign key(idPOproduct) references product(idProduct),
    constraint fk_POorder foreign key(idPOorder) references order_product(idOrder)

);

create table if not exists storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_product_seller foreign key (idLproduct) references product(idProduct),
    constraint fk_product_storage foreign key (idLstorage) references  productStorage(idProductStorage)

);

create table if not exists productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier,idPsProduct),
    constraint fk_product_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)



);