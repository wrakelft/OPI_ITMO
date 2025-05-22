package org.GleBlassUSA.beans;


import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.GleBlassUSA.dao.PointDao;
import org.GleBlassUSA.models.Point;

@ApplicationScoped
public class PointService {
    private final PointDao pointDao = PointDao.getInstance();
    @Inject
    private PointTracker pointTracker;

    public void addPoint(Point point) {
        pointDao.addPoint(point); // Чистая работа с БД
        pointTracker.checkPoint(point); // Мониторинг
    }
}
