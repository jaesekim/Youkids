package com.capsule.youkids.place.entity;

import com.capsule.youkids.global.time.BaseTimeEntity;
import lombok.*;
import org.hibernate.annotations.Index;
import javax.persistence.*;
import java.util.UUID;

@Entity
@Getter
@NoArgsConstructor
public class Bookmark extends BaseTimeEntity {

    @Id
    @Column
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int bookmarkId;

    @Column(columnDefinition = "BINARY(16)")
    @Index(name = "idx_user_id")
    private UUID userId;

    @Column
    private int placeId;

    @Builder
    public Bookmark(UUID userId, int placeId) {
        this.userId = userId;
        this.placeId = placeId;
    }
}
