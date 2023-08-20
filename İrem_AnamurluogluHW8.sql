--1.Soru çıkış yılı 2006 olan rental duration 3 ve 7 arasında olan filmlerin sayısı
--kategori ismi, language, toplam film
select c.name as category_name, l.name as language_name, count(f.film_id) as toplam_film from category c
left join film_category fc
on c.category_id=fc.category_id
left join film f
on f.film_id=fc.film_id
left join language l
on l.language_id=f.language_id
where f.release_year=2006 and f.rental_duration between 3 and 7
group by c.name, l.name


--2.Soru Hangi store da hangi filmler kaç adet stokta var
-- store_id, film_adi, inventory adeti
select c.store_id as store_id,f.title as film_adı, count(i.inventory_id) as inventory_adeti from customer c
left join rental r
on r.customer_id=c.customer_id
left join inventory i
on i.inventory_id=r.inventory_id
left join film f
on f.film_id=i.film_id
group by c.store_id,f.title 

--soru 3: film kategorisi animasyon olan  ve ülkeleri Anguilla
--Argentina
--Armenia
--Australia
--Austria
--Azerbaijan
--Bahrain
--Bangladesh
--Belarus
--Bolivia
--Brazil
--Brunei
--Bulgaria
--Cambodia
--Cameroon
--Canada
--bu  ülkerler olan müşteriler kimdir?

select ca.name, ct.country, c.customer_id from country ct
left join city cy
using(country_id)
left join address a
using(city_id)
left join customer c
using(address_id)
left join rental r
using(customer_id)
left join inventory i
using(inventory_id)
left join film f
using(film_id)
left join film_category fc
using(film_id)
left join category ca
using(category_id)
where ca.name = 'Animation' and ct.country in ('Anguilla','Argentina','Armenia','Australia','Austria','Azerbaijan','Bahrain','Bangladesh','Belarus','Bolivia','Brazil','Brunei','Bulgaria','Cambodia','Cameroon','Canada')
group by ct.country, ca.name, c.customer_id

--4.Soru şaun aktif olan müşterilerin kiraladıklarının isimleri ve adetleri
--activebool
select f.title as film_ismi, count(f.film_id) as adet from film f
left join inventory i
on f.film_id=i.film_id
left join rental r
on r.inventory_id=i.inventory_id
left join customer c
using(customer_id)
where c.activebool = 'true'
group by f.title

--5.Soru Animasyon ve Childer kategorilerinde stafflar toplam kaç film kiralamış ve toplam ne kadarlık kiralamış.
select c.name as category_name, count(r.rental_id) as toplam_rental, sum(p.amount) as toplam_amount from staff s
left join payment p
on s.staff_id=p.staff_id
left join rental r
on r.rental_id=p.rental_id
left join inventory i
on i.inventory_id=r.inventory_id
left join film f
on f.film_id=i.film_id
left join film_category fc
on fc.film_id=f.film_id
left join category c
using(category_id)
where c.name in ('Animation', 'Children')
group by c.name

