"use client";

import React, {useState} from "react";
import {Menu} from "lucide-react";

export default function Sidebar({children}: { children: React.ReactNode }) {
    const [open, setOpen] = useState(false);

    return (
        <div className="flex h-screen">
            <aside
                className={`bg-gray-900 text-white transition-all duration-300 ${
                    open ? "w-64" : "w-16"
                } flex flex-col`}
            >
                <button
                    onClick={() => setOpen(!open)}
                    className="p-4 focus:outline-none hover:bg-gray-800"
                >
                    <Menu size={24}/>
                </button>

                <div className="flex-1 p-2">
                    {

                    }
                </div>
            </aside>

            <main
                className={`flex-1 transition-all duration-300 ${
                    open ? "ml-0" : "ml-0"
                }`}
            >
                {children}
            </main>
        </div>
    );
}