from ultralytics import YOLO
import numpy as np

from ...core.config import settings
from ...core.nutrition import lookup


_model = YOLO(settings.YOLO_WEIGHTS)


def detect_food(img_bgr: np.ndarray):
    res = _model.predict(img_bgr, conf=settings.CONF_THRES, verbose=False)[0]
    out = []
    for box in res.boxes:
        name = _model.name[int(box.cls[0])]
        conf = float(box.conf[0])
        nut = lookup(name)
        out.append({
            "name": name,
            "conf": conf,
            "kcal": nut["kcal"],
            "protein": nut["protein"],
        })
        return out