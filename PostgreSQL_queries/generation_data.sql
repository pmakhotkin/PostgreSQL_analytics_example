--create users

create table IF NOT EXISTS users (
userid bigint primary key,
age integer
);

do $$
begin
for i in 1..2000 loop
    insert into users (userid,age) values(i,floor(random()*(50-18+1)+18));
    end loop;
    end; $$;

--create table items

create table IF NOT EXISTS items (
itemid varchar(20) primary key,
price numeric
);

do $$
begin
    for i in 1..100 loop
        insert into items
        (
        itemid,
        price
        )
        values
        (
        concat('item ',i),
        round(cast(random()*(40000-400)+400 as numeric),2)
        );
    end loop;
end; $$;

--create table purchases

create table IF NOT EXISTS purchases (
purchaseid bigint primary key,
userid bigint,
itemid varchar(50),
date date
);

do $$
begin
    for i in 1..10000 loop
        insert into purchases 
        (
        purchaseid,
        userid,
        itemid,
        date
        ) 
        values
        (
        i,
        floor(random()*(2000-1+1)+1),
        concat('item ', floor(random()*(100-1+1)+1)),
        cast(NOW() - (random() * (NOW()+'1095 days' - NOW())) as date)
        );
    end loop;
end; $$;

--create view statistic_view

CREATE OR REPLACE VIEW public."statistic_view"
 AS
SELECT t1.userid,t1.age,t2.purchaseid,t2.date,t3.itemid,t3.price FROM public.users as t1
left join purchases as t2 on t1.userid = t2.userid
left join items as t3 on t2.itemid = t3.itemid
where t2.purchaseid is not null
ORDER BY t2.itemid ASC;

ALTER TABLE public."statistic_view"
    OWNER TO postgres;