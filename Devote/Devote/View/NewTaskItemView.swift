//
//  NewTaskItemView.swift
//  Devote
//
//  Created by user219285 on 3/30/23.
//

import SwiftUI

struct NewTaskItemView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task: String = ""
    private var isButtonDisable: Bool {
        return task.isEmpty
    }
    @Binding var isShowing: Bool
    
    //MARK: - Function
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyvoard()
            isShowing = false
        }
    }
    
    //MARK: - Body
    var body: some View {
        VStack() {
            Spacer()
            
            VStack(spacing: 16) {
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                
                Button(action: {
                    addItem()
                    playSound(sound: "sound-ding", type: "mp3")
                    feedback.notificationOccurred(.success)
                }, label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                })  //button
                .disabled(isButtonDisable)
                .onTapGesture {
                    if isButtonDisable {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(isButtonDisable ? Color.blue : Color.pink)
                .cornerRadius(10)
            } // vstack
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
            )
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.65), radius: 24)
            .frame(maxWidth: 640)
        }
        .padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
