use ecommerce;


select count(*) from seller;
select * from clients c, order_product o where c.idClient = o.idOrderClient;

select Fname, Lname,  idOrder, orderStatus  from clients c, order_product o where c.idClient = o.idOrderClient;

select concat(Fname,'',Lname) as Client, idOrder as OrderID, orderStatus as Situação from clients c, order_product o where c.idClient = o.idOrderClient;

select count(idOrderClient) as PedidosCancelados from order_product where orderStatus= 'Cancelado';

