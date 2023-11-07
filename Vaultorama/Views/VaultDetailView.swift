//
//  VaultDetailView.swift
//  Vaultorama
//
//  Created by Olivier Guillemot on 07/11/2023.
//

import SwiftUI
import SwiftData

struct VaultDetailView: View {
    
    let vault: Vault
    
    init(vault: Vault) {
        self.vault = vault
    }
    var body: some View {
        GridView(vault: vault)
    }
}

struct GridView: View {
    
    let vault: Vault
    
    init(vault: Vault) {
        self.vault = vault
    }

    private static var initialColumns = 2
    @State private var isEditing = false
    @State private var isOn: Bool = false

    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns: Double = Double(initialColumns)

    var body: some View {
        VStack {
//            if isEditing {
//                ColumnStepper(title: columnsTitle, range: 1...8, columns: $gridColumns)
//                .padding()
//            }
            ScrollView {
                LazyVGrid(columns: gridColumns) {
                    ForEach(vault.files, id:\.fileName) { item in
                        GeometryReader { geo in
                            GridItemView(size: geo.size.width, file: item )
                        }
                        .cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(alignment: .topTrailing) {
                            if isEditing {
                                Button {
                                    withAnimation {
//                                        dataModel.removeItem(item)
                                    }
                                } label: {
                                    Image(systemName: "xmark.square.fill")
                                                .font(Font.title)
                                                .symbolRenderingMode(.palette)
                                                .foregroundStyle(.white, .red)
                                }
                                .offset(x: 7, y: -7)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .toolbar{
            ToolbarItemGroup{
//                Toggle(isOn: $isGridLayout) {
//                    Image(systemName: "square.grid.2x2.fill")
//                }
//                Spacer()
//                Slider(
//                    value: $numColumns,
//                    in: 2...10,
//                    step: 1,
//                    minimumValueLabel:
//                        Text("0").font(.system(size: 10)),
//                    maximumValueLabel:
//                        Text("10").font(.system(size: 14)),
//                    onEditingChanged: <#T##(Bool) -> Void#>
//                ) {
//                    Text("Font Size (\(Int(numColumns)))")
//                }
                VStack{
                    Slider(
                            value: $numColumns,
                            in: 2...10
                        )
                    {
                            Text("Speed")
                        } minimumValueLabel: {
                            Text("2")
                        } maximumValueLabel: {
                            Text("10")
                        }
                    Text("\(Int(numColumns.rounded()))")
                            .foregroundColor(isEditing ? .red : .blue)
                    
                }.frame(width: 150)
                    
                }
               
        }.onAppear {
            gridColumns = Array(repeating: GridItem(.flexible()), count: Int(numColumns))
            print(numColumns)
        
        
//             ToolbarItem(placement: .secondaryAction) {
//                 
//                 HStack {
//                    Button {
//                        withAnimation { isGridLayout.toggle() }
//                    } label : {
//                        Image(systemName: "square.grid.2x2.fill")
//                    }.buttonStyle(.borderless)
//                }
//            }
//            ToolbarItem(placement: .primaryAction) {
//                    HStack {
//                        Button(isEditing ? "Done" : "Edit") {
//                            withAnimation { isEditing.toggle() }
//                        }
//                            Button {
//                                isAddingPhoto = true
//                            } label: {
//                                Image(systemName: "plus")
//                            }
//                            .disabled(isEditing)
//                    }
//                
//            }
    }
        
        }
}

 




#Preview {
    ContentView()
}
