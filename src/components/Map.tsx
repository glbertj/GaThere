"use client";

import { useEffect, useRef } from "react";
import "leaflet/dist/leaflet.css";
import L from "leaflet";

export default function Map() {
    const mapRef = useRef<L.Map | null>(null);

    useEffect(() => {
        if (!mapRef.current) {
            const map = L.map("map").setView([-6.1754, 106.8272], 15);
            mapRef.current = map;

            L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
                attribution: '&copy; OpenStreetMap contributors',
            }).addTo(map);

            L.marker([-6.1754, 106.8272])
                .addTo(map)
                .bindPopup("Monas, Jakarta")
                .openPopup();
        }
    }, []);

    return <div id="map" className="w-full h-full" />;
}