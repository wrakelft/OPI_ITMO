package org.GleBlassUSA.beans;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.context.Destroyed;
import jakarta.enterprise.context.Initialized;
import jakarta.enterprise.event.Observes;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import org.GleBlassUSA.dao.PointDao;
import org.GleBlassUSA.models.Point;

import javax.management.*;
import java.io.Serializable;

@Named("pointTracker")
@ApplicationScoped
public class PointTracker extends NotificationBroadcasterSupport implements Serializable, PointTrackerMBean {

    private int sequenceNumber = 0;

    @Inject
    private PointDao pointDao;

    public void init(@Observes @Initialized(ApplicationScoped.class) Object unused) {
        org.GleBlassUSA.beans.MBeanRegistryUtil.registerBean(this, "pointTracker");
    }

    public void destroy(@Observes @Destroyed(ApplicationScoped.class) Object unused) {
        MBeanRegistryUtil.unregisterBean(this);
    }

    @Override
    public long getTotalPoints() {
        return pointDao.getPoints().size();
    }

    @Override
    public long getMissedPoints() {
        return pointDao.getPoints().stream()
                .filter(p -> !inArea(p))
                .count();
    }

    public void checkPoint(Point point) {
        if (inArea(point)) {
            sendOut(point);
        }
    }

    private boolean inArea(Point point) {
        return point.calculate();
    }

    private void sendOut(Point point) {
        Notification notification = new Notification(
                "Point out of bounds",
                this.getClass().getName(),
                sequenceNumber++,
                System.currentTimeMillis(),
                String.format("Point (%.2f, %.2f out of bounds:", point.getX(), point.getY())
        );
        sendNotification(notification);
    }

    @Override
    public MBeanNotificationInfo[] getNotificationInfo() {
        String[] types = new String[]{
                AttributeChangeNotification.ATTRIBUTE_CHANGE
        };
        String name = AttributeChangeNotification.class.getName();
        String description = "Point out of bounds notification";
        return new MBeanNotificationInfo[]{
                new MBeanNotificationInfo(types, name, description)
        };
    }
}
