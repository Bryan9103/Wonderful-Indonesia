//
//  LocationView.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/3.
//

import SwiftUI
import MapKit

struct LocationView: View {
    func locationCoordinate(lat:String, lng:String) -> CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!)
    }
    
    let item: LocationInfo
    @State private var searchResult: [MKMapItem] = []

    var body: some View {
        Map(){
            Marker("HERE", systemImage: "figure.wave", coordinate: locationCoordinate(lat: item.lat, lng: item.lng))
                .tag(1)
        }
        .navigationBarTitleDisplayMode(.inline)
        .mapStyle(.imagery)
        .safeAreaInset(edge: .bottom, content: {
            HStack(alignment: .center){
                Spacer()
                Text(item.displayName) //data binding
                    .padding(.top)
                Spacer()
            }
            .padding(.bottom)
            .background(.thickMaterial)
        })
        .mapControls{
            MapCompass()
                .mapControlVisibility(.visible)
            MapScaleView()
        }
    }
    
}

#Preview (){
    LocationView(item: LocationInfo( id: "OS-178084303", displayName: "Pasar Bogor, Bogor, Jawa Barat, Indonesia", lng: "106.80063", lat: "-6.60358", coordinate: "106.80063,-6.60358"))
}
