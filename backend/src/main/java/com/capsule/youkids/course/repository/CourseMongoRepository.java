package com.capsule.youkids.course.repository;

import com.capsule.youkids.course.dto.CourseResponseDto;
import com.capsule.youkids.course.entity.CourseMongo;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface CourseMongoRepository extends MongoRepository<CourseMongo, Integer> {

    Optional<CourseResponseDto> findByCourseId(UUID courseId);
}
