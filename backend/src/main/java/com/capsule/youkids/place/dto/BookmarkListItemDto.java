package com.capsule.youkids.place.dto;

import com.capsule.youkids.place.entity.Place;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class BookmarkListItemDto {

    private int placeId;
    private String name;
    private String address;
    private Double latitude;
    private Double longitude;
    private String category;
    private String imageUrl;
    private int visitedReviewNum;

    public BookmarkListItemDto(Place place) {
        this.placeId = place.getPlaceId();
        this.name = place.getName();
        this.address = place.getAddress();
        this.latitude = place.getLatitude();
        this.longitude = place.getLongitude();
        this.category = place.getCategory();
        this.imageUrl = place.getImages().get(0).getUrl();
        this.visitedReviewNum = place.getVisitedReviewNum();
    }
}
