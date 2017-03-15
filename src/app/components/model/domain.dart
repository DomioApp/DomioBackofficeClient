class Domain {
    String Name;
    String Owner;
    num PricePerMonth;
    bool IsApproved;
    bool IsRented;
    bool IsVisible;

    Domain() {}

    Domain.fromMap(Map domainMap) {
        Name = domainMap['name'];
        Owner = domainMap['owner'];
        PricePerMonth = domainMap['price_per_month'];
        IsApproved = domainMap['is_approved'];
        IsRented = domainMap['is_rented'];
        IsVisible = domainMap['is_visible'];
    }
}