////
////  ContentView.swift
////  Vaultorama
////
////  Created by Olivier Guillemot on 19/10/2023.
////
//
//import SwiftUI
//import SwiftData
//
//struct SplitNavigationView: View {
//    
////    @EnvironmentObject var dataModel: VaultDataModel
////    @State private var vaultIds: Set<Vault.ID> = []
// 
//    
//    @Query(animation: .snappy) private var vaults: [Vault]
//    
//    var body: some View {
//        NavigationSplitView {
//            List(vaults ) { vault in
//                VaultListItemView(vault: vault)
//            }
//            .navigationSplitViewColumnWidth(300)
//            .listStyle(.plain)
//            
//        } detail: {
//            
//        Image("sample-image")
//                .resizable()
//                .frame(width: 300, height: 200)
//                .aspectRatio(contentMode: .fit)
//            
//        }
//    }
//}
//
//#Preview {
//    SplitNavigationView().environmentObject(VaultDataModel())
//}
//
//
//
