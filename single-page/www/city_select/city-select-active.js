$(function () {
    $('#01_addr_contact_province, #01_addr_contact_city').citylist({
        data    : data,
        id      : 'id',
        children: 'cities',
        name    : 'name',
        metaTag : 'name'
    });
});